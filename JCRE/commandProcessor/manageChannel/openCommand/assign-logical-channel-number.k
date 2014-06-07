require "open-command-syntax.k"
require "open-command.k"
require "../../../responses/response-handler.k"

module ASSIGN-LOGICAL-CHANNEL-NUMBER
	imports OPEN-COMMAND-SYNTAX
	imports OPEN-COMMAND
	imports RESPONSE-HANDLER

	/* ******************************************************************************** */
	/*    look in the unusedLCNo cell to see if there are any unopened logical channels */
	/*   if there is such a channel number take the first one from the list and 		*/
	/*   open that channel 																*/
	/* ******************************************************************************** */
	rule <k> 'assignNewLogicalChannelNumber[OriginalChannelNo:Int] => 'openAssignedNewLogicalChannel [OriginalChannelNo, LCNo] ...</k>
		 <unusedLCNo>
		 	...
		 	ListItem(LCNo:Int) => . 
		 	...
		 </unusedLCNo>

	/* ******************************************************************************** */
	/*   if the list is empty															*/
	/* ******************************************************************************** */
	rule <k> 'assignNewLogicalChannelNumber[OriginalChannelNo:Int] => 'response ... </k>
		 <unusedLCNo>
		 	.List
		 </unusedLCNo>
		 <response>
        	...
          	<sw1> _ => "6A" </sw1>
         	<sw2> _ => "81" </sw2>
        	...
      	</response>


endmodule