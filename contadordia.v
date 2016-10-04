`timescale 1ns / 10ps

module contadordia(
		input wire clk,
		input wire boton_aumenta, boton_disminuye,
		output reg [4:0] countdays
    );
	 
initial countdays = 0;
	
always @(posedge clk) begin
	if ((boton_aumenta)&&(countdays == 31))
		countdays = 1;
	else if ((boton_aumenta)&&(countdays != 31))
		countdays = countdays + 1'b1;
	else if ((boton_disminuye)&&(countdays != 1)) 
		countdays = countdays - 1'b1;
	else if ((boton_disminuye)&&(countdays == 1))
		countdays = 31;
end

endmodule
