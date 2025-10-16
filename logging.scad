/*
	Description: 
	A library to help with logging 
	
	Including:
	Only works with 'include'

	Requirements:
	Requires the BOSL2 library found at https://github.com/BelfrySCAD/BOSL2
*/

include <BOSL2/std.scad>

log_level=5;
log_levels=["No Logging","Standard Logging","Verbose Logging","Debug Logging"];

// Shows all log levels configured in the log_levels list and their corresponding index
module echo_log_levels(mark_current){
	levels=[for(i=[0:len(log_levels)-1]) str(i,": ",log_levels[i], mark_current && log_level==i?" ← Current":"")];
	level_display=str_join(levels, "\n\t");
	echo(str("Log Levels:\n\t",level_display));
}

// Shows the current log level
module echo_current_log_level() {
	if (log_level<0 || log_level>=len(log_levels)) echo(str("Current Log Level is invalid.  Expected value is between 0 and ", len(log_levels)-1, ". Current level is → ", log_level));
	else echo(str("Current Log Level → ", log_level, ": ", log_levels[log_level]));
}

// Echoes if the condition is true
module log_if(message,condition){
	if (condition)
		echo(message);
}


// Logs the provided message if the level is greater than or equal to the current log_level
module log_message(message,level=1){
	if (log_level>0 && level>=log_level)
		echo(message);
}

// Logs the provided variable if the level is greater than or equal to the current log_level
module log_variable(name,value,level=1){
	if (log_level>0 && level>=log_level)
		echo(str(name, ": ", value));
}