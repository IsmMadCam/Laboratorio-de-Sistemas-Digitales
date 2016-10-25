`timescale 1ns / 10ps

module decocontadores(
	input wire [7:0] countyears,
	input wire [7:0] countmonths,
	input wire [7:0] countdays,
	input wire [7:0] counthours,
	input wire [7:0] countmins,
	input wire [7:0] countsecs,
	output reg [3:0] ytens, //decenas years
	output reg [3:0] yones, //uniades years
	output reg [3:0] mtens, //decenas meses
	output reg [3:0] mones, //unidades meses
	output reg [3:0] dtens, //decenas dias
	output reg [3:0] dones, //unidades dias
	output reg [3:0] htens, //decenas horas
	output reg [3:0] hones, //unidades horas
	output reg [3:0] mintens, //decenas minutos
	output reg [3:0] minones, //unidades minutos
	output reg [3:0] tens, //decenas segundos
	output reg [3:0] ones //unidades segundos
    );
	 
	 integer i;
	 integer j;
	 integer k;
	 integer l;
	 integer m;
	 integer n;
	 
	 always @(countsecs)
	 begin
		tens = 4'd0;
		ones = 4'd0;
		
		for (i = 7; i >= 0; i = i - 1)
		begin
			if (tens >= 5)
				tens = tens + 2'd3;
			if (ones >= 5)
				ones = ones + 2'd3;
			
			tens = tens << 1;
			tens[0] = ones[3];
			ones = ones << 1;
			ones[0] = countsecs[i];
		end
	end
	
	always @(countmins)
	begin
		mintens = 4'd0;
		minones = 4'd0;
		
		for (j = 7; j >= 0; j = j - 1)
		begin
			if (mintens >= 5)
				mintens = mintens + 2'd3;
			if (minones >= 5)
				minones = minones + 2'd3;
				
			mintens = mintens << 1;
			mintens[0] = minones[3];
			minones = minones << 1;
			minones[0] = countmins[j];
		end
	end
	
	always @(counthours)
	begin
		htens = 4'd0;
		hones = 4'd0;
		
		for (k = 7; k >= 0; k = k - 1)
		begin
			if (htens >= 5)
				htens = htens + 2'd3;
			if (hones >= 5)
				hones = hones + 2'd3;
				
			htens = htens << 1;
			htens[0] = hones[3];
			hones = hones << 1;
			hones[0] = counthours[k];
		end
	end
	
	always @(countdays)
	begin
		dtens = 4'd0;
		dones = 4'd0;
		
		for (l = 7; l >= 0; l = l - 1)
		begin
			if (dtens >= 5)
				dtens = dtens + 2'd3;
			if (dones >= 5)
				dones = dones + 2'd3;
				
			dtens = dtens << 1;
			dtens[0] = dones[3];
			dones = dones << 1;
			dones[0] = countdays[l];
		end
	end
	
	always @(countmonths)
	begin
		mtens = 4'd0;
		mones = 4'd0;
		
		for (m = 7; m >= 0; m = m - 1)
		begin
			if (mtens >= 5)
				mtens = mtens + 2'd3;
			if (mones >= 5)
				mones = mones + 2'd3;
				
			mtens = mtens << 1;
			mtens[0] = mones[3];
			mones = mones << 1;
			mones[0] = countmonths[m];
		end
	end

	always @(countyears)
	begin
		ytens = 4'd0;
		yones = 4'd0;
		
		for (n = 7; n >= 0; n = n - 1)
		begin
			if (ytens >= 5)
				ytens = ytens + 2'd3;
			if (yones >= 5)
				yones = yones + 2'd3;
				
			ytens = ytens << 1;
			ytens[0] = yones[3];
			yones = yones << 1;
			yones[0] = countyears[n];
		end
	end

endmodule
