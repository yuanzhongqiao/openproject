// -- copyright
// OpenProject is an open source project management software.
// Copyright (C) 2012-2023 the OpenProject GmbH
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License version 3.
//
// OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
// Copyright (C) 2006-2013 Jean-Philippe Lang
// Copyright (C) 2010-2013 the ChiliProject Team
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
// See COPYRIGHT and LICENSE files for more details.
//++

// 'Global' dependencies
//
// dependencies required by classic (Rails) and Angular application.

// Lodash
require('expose-loader?_!lodash');

// jQuery
require('expose-loader?jQuery!jquery');
require('jquery-ujs');

require('expose-loader?mousetrap!mousetrap/mousetrap.js');

// Angular dependencies
require('expose-loader?dragula!dragula/dist/dragula.min.js');
require('@uirouter/angular');

// Jquery UI
require('jquery-ui/ui/core.js');
require('jquery-ui/ui/position.js');
require('jquery-ui/ui/disable-selection.js');
require('jquery-ui/ui/widgets/sortable.js');
require('jquery-ui/ui/widgets/dialog.js');
require('jquery-ui/ui/widgets/tooltip.js');

require('expose-loader?moment!moment');
require('moment/locale/en-gb.js');
require('moment/locale/de.js');

require('jquery.caret');
// Text highlight for autocompleter
require('mark.js/dist/jquery.mark.min.js');
// Micro Text fuzzy search library
require('fuse.js');

require('moment-timezone/builds/moment-timezone-with-data.min.js');
// eslint-disable-next-line import/extensions,import/no-extraneous-dependencies
require('@primer/view-components/app/assets/javascripts/primer_view_components.js');

require('expose-loader?URI!urijs');
require('urijs/src/URITemplate');

// Localization for fullcalendar
require('@fullcalendar/core/locales-all');
