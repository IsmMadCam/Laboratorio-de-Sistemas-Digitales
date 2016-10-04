`timescale 1ns / 10ps

module contadorsegundos(
		input wire clk,
		input wire boton_aumenta, boton_disminuye,
		output reg [5:0] countsecs
    );

initial countsecs = 0;

always @(posedge clk) begin
	if ((boton_aumenta)&&(countsecs == 59))
		countsecs = 0;
	else if ((boton_aumenta)&&(countsecs != 59))
		countsecs = countsecs + 1'b1;
	else if ((boton_disminuye)&&(countsecs != 0)) 
		countsecs = countsecs - 1'b1;
	else if ((boton_disminuye)&&(countsecs == 0))
		countsecs = 59;
end

endmodule
