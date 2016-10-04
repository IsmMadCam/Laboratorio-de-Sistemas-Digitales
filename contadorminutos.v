`timescale 1ns / 10ps

module contadorminutos(
		input wire clk,
		input wire boton_aumenta, boton_disminuye,
		output reg [5:0] countmins
    );
	 
initial countmins = 0;

always @(posedge clk) begin
	if ((boton_aumenta)&&(countmins == 59))
		countmins = 0;
	else if ((boton_aumenta)&&(countmins != 59))
		countmins = countmins + 1'b1;
	else if ((boton_disminuye)&&(countmins != 0)) 
		countmins = countmins - 1'b1;
	else if ((boton_disminuye)&&(countmins == 0))
		countmins = 59;
end

endmodule
