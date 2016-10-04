`timescale 1ns / 10ps

module contadormes(
		input wire clk,
		input wire boton_aumenta, boton_disminuye,
		output reg [3:0] countmonths
    );

initial countmonths = 0;

always @(posedge clk) begin
	if ((boton_aumenta)&&(countmonths == 12))
		countmonths = 1;
	else if ((boton_aumenta)&&(countmonths != 12))
		countmonths = countmonths + 1'b1;
	else if ((boton_disminuye)&&(countmonths != 1)) 
		countmonths = countmonths - 1'b1;
	else if ((boton_disminuye)&&(countmonths == 1))
		countmonths = 12;
end


endmodule
