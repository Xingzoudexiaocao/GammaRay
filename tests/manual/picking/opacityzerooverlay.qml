/*
  This file is part of GammaRay, the Qt application inspection and
  manipulation tool.

  Copyright (C) 2014-2022 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com
  Author: Christoph Sterz<christoph.sterz@kdab.com>

  Licensees holding valid commercial KDAB GammaRay licenses may use this file in
  accordance with GammaRay Commercial License Agreement provided with the Software.

  Contact info@kdab.com if any conditions of this licensing are not clear to you.

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0


import QtQuick 2.0

Item {
  width: 100
  height: 100

  Rectangle{
      id: invisibleoverlay

      color:"#ffffffff"
      anchors.fill: parent
      opacity: 0

      Rectangle {
        id: visibleChildOfInvisibleParent

        color: "#ffff0000"
        anchors.fill: parent
        opacity: 1
      }
  }

  Rectangle {
    id: yellowrect

    color: "#ffffff00"
    anchors.centerIn: parent
    z: -40
    width: parent.width/2
    height: parent.height/2
  }
}
