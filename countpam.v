`timescale 1ns / 10ps

module countpam(
		input wire clk,
		input wire boton_izquierda, boton_derecha,
		output reg [1:0] countpam
    );
	 
initial countpam = 0;

always @(posedge clk) begin
	if ((boton_derecha)&&(countpam == 3))
		countpam = 0;
	else if ((boton_derecha)&&(countpam != 3))
		countpam = countpam + 1'b1;
	else if ((boton_izquierda)&&(countpam != 0)) 
		countpam = countpam - 1'b1;
	else if ((boton_izquierda)&&(countpam == 0))
		countpam = 3;
end

endmodule
