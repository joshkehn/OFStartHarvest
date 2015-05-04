-- Date: May 2nd, 2015
-- Copyright (c) 2015 Joshua Kehn <josh@kehn.us>
-- License: MIT http://opensource.org/licenses/MIT
-- Version: 1.0

set DEFAULT_HARVEST_PROJECT to ""
set DEFAULT_HARVEST_TASK to "Development"
set HARVEST_ICON to alias "Applications:Harvest.app:Contents:Resources:harvest.icns"

on figureTask(taskItem, taskContext, taskProject, harvestProject)
	set harvestTask to my DEFAULT_HARVEST_TASK
	set projectName to ""
	set taskContextName to ""
	if taskContext is not missing value then
		set taskContextName to get name of taskContext
	end if
	if taskProject is not missing value then
		set projectName to get name of taskProject
	end if


	-- Add custom logic here to manipulate the task.

	-- For example, select an "Overhead" task for certain contexts:
	set OH_TASKS to {"Email", "Phone", "Skype"}
	if OH_TASKS contains taskContextName then
		set harvestTask to "Overhead"
	end if

	-- Conditionally set the task per-project
	if harvestProject is "Example Project" then
		set harvestTask to "Example Task"
	end if

	return harvestTask
end figureTask

on figureProject(taskItem, taskNote, taskProject, projectNote, projectFolder)
	set harvestProject to my DEFAULT_HARVEST_PROJECT

	set taskName to get name of taskItem
	-- Bug in OF, can't fetch note in handler. Issue #1364404
	-- set taskNote to get note of taskItem
	set projectName to ""
	set folderName to ""

	if taskProject is not missing value then
		set projectName to get name of taskProject
	end if
	if projectFolder is not missing value then
		set folderName to get name of projectFolder
	end if


	-- Conditionally set the project here. Sometimes this is an identifier
	-- residing in a name or note of either the task or project.
	set projectConditions to {offset of "Project" in projectName, offset of "Project" in projectNote, offset of "Project" in taskName, offset of "Project" in taskNote}
	set projectFound to projectConditions as text
	if projectFound is not "0000" then
		set harvestProject to "Project"
	end if

	return harvestProject
end figureProject

tell front window of application "OmniFocus"
	-- Make sure something has been selected
	set taskItems to get selected tree of content
	if (count of taskItems) is equal to 0 then
		display dialog "No items selected to start." with title "Error"
		return
	end if

	-- Consider the taskItem to be the first of any selected items
	set taskItem to value of item 1 of taskItems

	-- Pull all the properties in use out at the start
	set taskNote to get note of taskItem
	set taskName to get name of taskItem

	-- Figuring out the project, if it exists, and the context and folder, if
	-- they exist
	set taskProject to get containing project of taskItem
	set taskProjectNote to ""
	if taskProject is not missing value then
		set taskProjectNote to get note of taskProject
	end if

	-- Task identifier here is blank
	set taskID to ""

	if taskNote is not "" then
		set taskID to paragraph 1 of taskNote
	end if

	-- Is this valid? If not, attempt to fetch from the project
	if taskProjectNote is not "" then
		if (offset of "[" in taskID) is not 1 then
			set taskID to paragraph 1 of taskProjectNote
		end if
	end if

	-- My taskID's always start with brackets (remote identifier). Customize
	-- this or remove it altogether.
	if (offset of "[" in taskID) is not 1 then
		set taskID to ""
	else
		set taskID to taskID & " "
	end if

	-- Now perform some logic to figure out what, if any, harvest values should
	-- be prefilled. Start with the default project/task and setting the note
	-- correctly. From there this note can be customized via a dialog and that
	-- is convinently copied to the clipboard.
	set harvestProject to my figureProject(taskItem, taskNote, taskProject, taskProjectNote, (get folder of taskProject))
	set harvestTask to my figureTask(taskItem, (get context of taskItem), taskProject, harvestProject)
	set harvestNote to taskID & taskName & ";"
	display dialog "Project: " & harvestProject & "
Task: " & harvestTask & "
Note: " default answer harvestNote with title "Start Harvest Timer" with icon HARVEST_ICON
	set harvestNote to get text returned of result
	set the clipboard to harvestNote
end tell

tell application "Harvest"
	reopen
	activate
end tell

tell application "System Events"
	-- Open new timer dialog
	keystroke "n" using command down

	-- Set the project
	keystroke harvestProject
	-- Move to task field
	keystroke tab
	-- Set the task
	keystroke harvestTask
	-- Move to note field
	keystroke tab
	-- Set the note
	keystroke harvestNote

	if harvestProject is not "" and harvestTask is not "" then
		-- Having a fully-qualified dialog (everything filled out assuming no
		-- errors), start this timer
		keystroke return
		keystroke return using command down
	else
		-- Move back to the project field since this requires additional entry
		repeat 4 times
			keystroke tab using shift down
		end repeat
	end if
end tell
