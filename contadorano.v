`timescale 1ns / 10ps

module contadorano(
		input wire clk,
		input wire boton_aumenta, boton_disminuye,
		output reg [6:0] countyears
    );
	 
initial countyears = 0;

always @(posedge clk) begin
	if ((boton_aumenta)&&(countyears == 99))
		countyears = 0;
	else if ((boton_aumenta)&&(countyears != 99))
		countyears = countyears + 1'b1;
	else if ((boton_disminuye)&&(countyears != 0)) 
		countyears = countyears - 1'b1;
	else if ((boton_disminuye)&&(countyears == 0))
		countyears = 99;
end



endmodule
