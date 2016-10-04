`timescale 1ns / 10ps

module contadorhoras(
		input wire clk,
		input wire boton_aumenta, boton_disminuye,
		output reg [4:0] counthours
    );
	 
initial counthours = 0;
	
always @(posedge clk) begin
	if ((boton_aumenta)&&(counthours == 23))
		counthours = 0;
	else if ((boton_aumenta)&&(counthours != 23))
		counthours = counthours + 1'b1;
	else if ((boton_disminuye)&&(counthours != 0)) 
		counthours = counthours - 1'b1;
	else if ((boton_disminuye)&&(counthours == 0))
		counthours = 23;
end

endmodule
