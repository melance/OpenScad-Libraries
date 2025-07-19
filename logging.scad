include <BOSL2/std.scad>

log_level=5;
log_levels=["No Logging","Standard Logging","Verbose Logging","Debug Logging"];

echo_log_levels(true);
echo_current_log_level();
log_message("Standard Logging", 1);
log_message("Verbose Logging", 2);
log_message("Debug Logging", 3);
log_variable("Test", log_levels,1);

module echo_log_levels(mark_current){
	levels=[for(i=[0:len(log_levels)-1]) str(i,": ",log_levels[i], mark_current && log_level==i?" ← Current":"")];
	level_display=str_join(levels, "\n\t");
	echo(str("Log Levels:\n\t",level_display));
}

module echo_current_log_level() {
	if (log_level<0 || log_level>=len(log_levels)) echo(str("Current Log Level is invalid.  Expected value is between 0 and ", len(log_levels)-1, ". Current level is → ", log_level));
	else echo(str("Current Log Level → ", log_level, ": ", log_levels[log_level]));
}

module log_message(message,log_level=1){
	if (log_level>0 && log_level>=log_level)
		echo(message);
}

module log_variable(name,value,log_level=1){
	if (log_level>0 && log_level>=log_level)
		echo(str(name, ": ", value));
}