#!/bin/bash
##############
# Description: This file will find all lti.xml files in current folder, will extract an ID and append that ID to the toolurl.
# Author     : Warren E. White
# Email      : wwhite@saanichschools.ca
#
# Copyright 2021 Warren E. White <wwhite@saanichschools.ca>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# get all lti.xml files
files=$(find . -name 'lti.xml' -type f)                                          

# loop over each lti.xml file
for xml in $files; do
  
  # get the instructorcustomparameters id
  id=$(xml sel -t -v "/activity/lti/instructorcustomparameters" ${xml});
 
  # get the toolurl
  toolurl=$(xml sel -t -v "/activity/lti/toolurl" ${xml});
  
  # check if type=page
  if [[ "$toolurl" =~ .*"type=page".* ]]; then
    # update page type toolurl with custom_id
	update=$(xml edit -L --update "/activity/lti/toolurl" --value "https://wcln.ca/local/lti/index.php?type=page&custom_${id}" ${xml});

  # check if type=book
  elif [[ "$toolurl" =~ .*"type=book".* ]]; then
    # update book type toolurl with custom_id
    update=$(xml edit -L --update "/activity/lti/toolurl" --value "https://wcln.ca/local/lti/index.php?type=book&custom_${id}" ${xml});
  fi

done;
