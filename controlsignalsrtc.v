`timescale 1ns / 10ps

module controlsignalsrtc(
		input wire clk,
		input wire enablee, enabled, enablel, 
		input wire ecs, erd, ewr, ead,
		input wire acs, ard, awr, aad,
		input wire lcs, lrd, lwr, lad,
		output reg cs, rd, wr, ad
    );
	 
initial cs = 0;
initial rd = 0;
initial wr = 0;
initial ad = 0;

always @(posedge clk) begin
	if ((enablee)&(!enablel)&(!enabled)) begin
			cs <= ecs;
			rd <= erd;
			wr <= ewr;
			ad <= ead;
	end
	else if ((enabled)&(!enablee)&(!enablel)) begin
			cs <= acs;
			rd <= ard;
			wr <= awr;
			ad <= aad;
	end
	else if ((enablel)&(!enabled)&(!enablee)) begin
			cs <= lcs;
			rd <= lrd;
			wr <= lwr;
			ad <= lad;
	end
	else begin
		cs <= 1;
		rd <= 1;
		ad <= 1;
		wr <= 1;
	end
end

endmodule
