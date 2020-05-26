#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


function calendar () {
  # options:
  # --text=text
  # Specifies the text that is displayed in the calendar dialog.

  # --day=day
  # Specifies the day that is selected in the calendar dialog. day must be a number between 1 and 31 inclusive.

  # --month=month
  # Specifies the month that is selected in the calendar dialog. month must be a number between 1 and 12 inclusive.

  # --year=year
  # Specifies the year that is selected in the calendar dialog.

  # --date-format=format
  # Specifies the format that is returned from the calendar dialog after date selection. 
  # The default format depends on your locale. Format must be a format that is acceptable to the strftime function, for example %A %d/%m/%y.

  if zenity --calendar \
  --title="Select a Date" \
  --text="Click on a date to select that date." \
  --date-format="%A %d/%m/%y"
  # \
    then echo $?
    else echo "No date selected"
  fi
}

function color () {
  # options:
  # --color=VALUE
  # Set the initial color.(ex: #FF0000)

  # --show-palette
  # Show the palette.

  COLOR=`zenity --color-selection --show-palette`
  case $? in
          0)
      echo "You selected $COLOR.";;
          1)
            echo "No color selected.";;
          -1)
            echo "An unexpected error has occurred.";;
  esac
}

function file () {
  # options:
  # --filename=filename
  # Specifies the file or directory that is selected in the file selection dialog when the dialog is first shown.

  # --multiple
  # Allows the selection of multiple filenames in the file selection dialog.

  # --directory
  # Allows only selection of directories in the file selection dialog.

  # --save
  # Set the file selection dialog into save mode.

  # --separator=separator
  # Specifies the string that is used to divide the returned list of filenames.

  FILE=`zenity --file-selection --title="Select a File"`

  case $? in
          0)
                  echo "\"$FILE\" selected.";;
          1)
                  echo "No file selected.";;
          -1)
                  echo "An unexpected error has occurred.";;
  esac
}

function form () {
  # options:
  # --add-entry=FieldName
  # Add a new Entry in forms dialog.

  # --add-password=FieldName
  # Add a new Password Entry in forms dialog. (Hide text)

  # --add-calendar=FieldName
  # Add a new Calendar in forms dialog.

  # --text=TEXT
  # Set the dialog text.

  # --separator=SEPARATOR
  # Set output separator character. (Default: | )

  # --forms-date-format=PATTERN
  # Set the format for the returned date. The default format depends on your locale. 
  # format must be a Format that is acceptable to the strftime function, for example %A %d/%m/%y.

  zenity --forms --title="Add Friend" \
	--text="Enter information about your friend." \
	--separator="," \
	--add-entry="First Name" \
	--add-entry="Family Name" \
	--add-entry="Email" \
	--add-calendar="Birthday" >> addr.csv

  case $? in
      0)
          echo "Friend added.";;
      1)
          echo "No friend added."
    ;;
      -1)
          echo "An unexpected error has occurred."
    ;;
  esac

}

function list () {
  # options:
  # Data for the dialog must specified column by column, row by row. Data can be provided to the dialog through standard input. Each entry must be separated by a newline character.
  # If you use the --checklist or --radiolist options, each row must start with either 'TRUE' or 'FALSE'.

  # The list dialog supports the following options:

  # --column=column
  # Specifies the column headers that are displayed in the list dialog. You must specify a --column option for each column that you want to display in the dialog.

  # --checklist
  # Specifies that the first column in the list dialog contains check boxes.

  # --radiolist
  # Specifies that the first column in the list dialog contains radio boxes.

  # --editable
  # Allows the displayed items to be edited.

  # --separator=separator
  # Specifies what string is used when the list dialog returns the selected entries.

  # --print-column=column
  # Specifies what column should be printed out upon selection. The default column is '1'. 'ALL' can be used to print out all columns in the list.

  zenity --list \
  --title="Choose the Bugs You Wish to View" \
  --column="Bug Number" --column="Severity" --column="Description" \
    992383 Normal "GtkTreeView crashes on multiple selections" \
    293823 High "GNOME Dictionary does not handle proxy" \
    393823 Critical "Menu editing does not work in GNOME 2.0"
}

function message () {
  zenity --error --text="Could not find /var/log/syslog."
  # zenity --info --text="Merge complete. Updated 3 of 10 files."
  # zenity --question --text="Are you sure you wish to proceed?"
  # zenity --warning --text="Disconnect the power cable to avoid electrical shock."
}

function notification () {
  # options:
  # --text=text
  # Specifies the text that is displayed in the notification area.

  # --listen=icon: 'text', message: 'text', tooltip: 'text', visible: 'text',
  # Listens for commands at standard input. At least one command must be specified. Commands are comma separated. A command must be followed by a colon and a value.

    zenity --notification\
    --window-icon="info" \
    --text="There are system updates necessary!"
}

function password () {
  # options:
  # --username
  # Display the username field.

  ENTRY=`zenity --password --username`

  case $? in
          0)
      echo "User Name: `echo $ENTRY | cut -d'|' -f1`"
      echo "Password : `echo $ENTRY | cut -d'|' -f2`"
      ;;
          1)
                  echo "Stop login.";;
          -1)
                  echo "An unexpected error has occurred.";;
  esac
}

function progress () {
  # options:
  # --text=text
  # Specifies the text that is displayed in the progress dialog.

  # --percentage=percentage
  # Specifies the initial percentage that is set in the progress dialog.

  # --auto-close
  # Closes the progress dialog when 100% has been reached.

  # --pulsate
  # Specifies that the progress bar pulsates until an EOF character is read from standard input.
  
  (
  echo "10" ; sleep 1
  echo "# Updating mail logs" ; sleep 1
  echo "20" ; sleep 1
  echo "# Resetting cron jobs" ; sleep 1
  echo "50" ; sleep 1
  echo "This line will just be ignored" ; sleep 1
  echo "75" ; sleep 1
  echo "# Rebooting system" ; sleep 1
  echo "100" ; sleep 1
  ) |
  zenity --progress \
    --title="Update System Logs" \
    --text="Scanning mail logs..." \
    --percentage=0

  if [ "$?" = -1 ] ; then
          zenity --error \
            --text="Update canceled."
  fi
}

function scale () {
  # options:
  # --text=TEXT
  # Set the dialog text. (Default: Adjust the scale value)

  # --value=VALUE
  # Set initial value. (Default: 0) You must specify value between minimum value to maximum value.

  # --min-value=VALUE
  # Set minimum value. (Default: 0)

  # --max-value=VALUE
  # Set maximum value. (Default: 100)

  # --step=VALUE
  # Set step size. (Default: 1)

  # --print-partial
  # Print value to standard output, whenever a value is changed.

  # --hide-value
  # Hide value on dialog.

  VALUE=`zenity --scale --text="Select window transparency." --value=50`

  case $? in
          0)
      echo "You selected $VALUE%.";;
          1)
                  echo "No value selected.";;
          -1)
                  echo "An unexpected error has occurred.";;
  esac
}

function text () {
  # options:
  # --text=text
  # Specifies the text that is displayed in the text entry dialog.

  # --entry-text=text
  # Specifies the text that is displayed in the entry field of the text entry dialog.

  # --hide-text
  # Hides the text in the entry field of the text entry dialog.
  if zenity --entry \
  --title="Add new profile" \
  --text="Enter name of new profile:" \
  --entry-text "NewProfile"
    then echo $?
    else echo "No name entered"
  fi
}

function textInfo () {
  # options:
  # --filename=filename
  # Specifies a file that is loaded in the text information dialog.

  # --editable
  # Allows the displayed text to be edited. The edited text is returned to standard output when the dialog is closed.

  # --font=FONT
  # Specifies the text font.

  # --checkbox=TEXT
  # Enable a checkbox for use like a 'I read and accept the terms.'

  # --html
  # Enable html support.

  # --url=URL
  FILE=`dirname $0`/COPYING

  zenity --text-info \
        --title="License" \
        --filename=$FILE \
        --checkbox="I read and accept the terms."

  case $? in
      0)
          echo "Start installation!"
    # next step
    ;;
      1)
          echo "Stop installation!"
    ;;
      -1)
          echo "An unexpected error has occurred."
    ;;
  esac
}

# calendar
# color
# file
# form
# list
# message
# notification
# password
# progress
# scale
# text
# textInfo

exit

# font: https://help.gnome.org/users/zenity/3.32/