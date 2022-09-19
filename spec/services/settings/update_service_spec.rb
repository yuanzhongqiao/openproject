#  OpenProject is an open source project management software.
#  Copyright (C) 2010-2022 the OpenProject GmbH
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License version 3.
#
#  OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
#  Copyright (C) 2006-2013 Jean-Philippe Lang
#  Copyright (C) 2010-2013 the ChiliProject Team
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 2
#  of the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#  See COPYRIGHT and LICENSE files for more details.

require 'spec_helper'

describe Settings::UpdateService do
  let(:user) { build_stubbed(:user) }
  let(:contract_success) { true }
  let(:contract_errors) { instance_double(ActiveModel::Error) }
  let(:contract_options) { {} }
  let(:instance) do
    described_class.new(user:, contract_options:)
  end
  let!(:contract) do
    contract_instance = instance_double(Settings::UpdateContract)

    allow(Settings::UpdateContract)
      .to receive(:new)
            .and_return(contract_instance)

    allow(contract_instance)
      .to receive(:validate)
            .and_return(contract_success)
    allow(contract_instance)
      .to receive(:errors)
            .and_return(contract_errors)

    contract_instance
  end
  let!(:params_contract) do
    contract_instance = instance_double(ParamsContract)

    allow(ParamsContract)
      .to receive(:new)
            .and_return(contract_instance)

    allow(contract_instance)
      .to receive(:valid?)
            .and_return(params_contract_success)
    allow(contract_instance)
      .to receive(:errors)
            .and_return(params_contract_errors)

    contract_instance
  end
  let(:params_contract_success) { true }
  let(:params_contract_errors) { instance_double(ActiveModel::Error) }
  let!(:setting) do
    allow(Setting)
      .to receive(:[]=)
            .with(setting_name, setting_value)
  end
  let!(:definition) do
    instance_double(Settings::Definition).tap do |definition_instance|
      allow(Settings::Definition)
        .to receive(:[])
              .and_call_original

      allow(Settings::Definition)
        .to receive(:[])
              .with(setting_name)
              .and_return(definition_instance)

      allow(definition_instance)
        .to receive(:on_change)
              .and_return(definition_on_change)
    end
  end
  let(:definition_on_change) do
    instance_double(Proc).tap do |proc|
      allow(proc)
        .to receive(:call)
    end
  end
  let(:setting_name) { :setting_name }
  let(:setting_value) { 'setting_value' }
  let(:params) { { setting_name => setting_value } }

  describe '#call' do
    shared_examples_for 'successful call' do
      it 'is successful' do
        expect(instance.call(params))
          .to be_success
      end

      it 'sets the value' do
        instance.call(params)

        expect(Setting)
          .to have_received(:[]=)
      end

      it 'calls the on_change handler' do
        instance.call(params)

        expect(definition_on_change)
          .to have_received(:call)
      end
    end

    shared_examples_for 'unsuccessful call' do
      it 'is not successful' do
        expect(instance.call(params))
          .not_to be_success
      end

      it 'does not call the on_change handler' do
        instance.call(params)

        expect(definition_on_change)
          .not_to have_received(:call)
      end

      it 'does not set the value' do
        instance.call(params)

        expect(Setting)
          .not_to have_received(:[]=)
      end
    end

    it_behaves_like 'successful call'

    context 'when the contract is not successfully validated' do
      let(:contract_success) { false }

      it_behaves_like 'unsuccessful call'
    end

    context 'with a provided params_contract that is successfully validated' do
      let(:contract_options) { { params_contract: ParamsContract } }
      let(:params_contract_success) { true }

      it_behaves_like 'successful call'
    end

    context 'with a provided params_contract that fails validation' do
      let(:contract_options) { { params_contract: ParamsContract } }
      let(:params_contract_success) { false }

      it_behaves_like 'unsuccessful call'
    end
  end
end
