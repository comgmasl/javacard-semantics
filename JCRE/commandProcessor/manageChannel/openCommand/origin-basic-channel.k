require "open-command-syntax.k"
require "../../../defaultApplets/default-applets-selection.k"

module ORIGIN-BASIC-CHANNEL
	imports DEFAULT-APPLETS-SELECTION
	imports OPEN-COMMAND-SYNTAX

	/* ************************************************************************************************* */
	/*																		   							 */
	/*		7. Determine the applet instance to be selected on the new logical channel.					 */
	/*		■ If the origin logical channel is the basic logical channel (logical channel 0),then:		 */
	/*		■ If a default applet instance for the new logical channel on the I/O interface				 */
	/*		is defined, pick the default applet instance for that logical channel as the 				 */
	/*		candidate for selection on the new logical channel.											 */
	/*																									 */
	/* ************************************************************************************************* */
	rule <k> 'determineAppletForNewChannel [OriginalChannelNo:Int, LCNo] => 
														'DefaultAppletForLogicalChannel [LCNo] ...</k>
		when OriginalChannelNo ==Int 0

	

endmodule