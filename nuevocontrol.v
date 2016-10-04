`timescale 1ns / 10ps

module nuevocontrol(
	input wire clk, reset,
	input wire rda, rdb, rdc, rdd, rde, rdf, rdg, rdh,
	input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh,
	input wire enini, enwrite, enread,
	input wire ensec, enmin, enhour, enday, enmonth, enyear,
	input wire configformato, 
	input wire docehorasa,
	input wire mandaunoa,
	output reg enablee, enabled, enablel,
	output reg cs, rd, wr, ad,
	output wire fkaa, fkab, fkac, fkad, fkae, fkaf, fkag, fkah,
	output wire lfkda, lfkdb, lfkdc, lfkdd, lfkde, lfkdf, lfkdg, lfkdh,
	output wire fkda, fkdb, fkdc, fkdd, fkde, fkdf, fkdg, fkdh
    );
	 
/*

 */

localparam STATE_Initial = 5'b00000,
	STATE_1 = 5'b00001,
	STATE_2 = 5'b00010,
	STATE_3 = 5'b00011,
	STATE_4 = 5'b00100,
	STATE_5 = 5'b00101,
	STATE_6 = 5'b00110,
	STATE_7 = 5'b00111,
	STATE_8 = 5'b01000,
	STATE_9 = 5'b01001,
	STATE_10 = 5'b01010,
	STATE_11 = 5'b01011,
	STATE_12 = 5'b01100,
	STATE_13 = 5'b01101,
	STATE_14 = 5'b01110,
	STATE_15 = 5'b01111,
	STATE_16 = 5'b10000,
	STATE_17 = 5'b10001,
	STATE_18 = 5'b10010,
	STATE_19 = 5'b10011,
	STATE_20 = 5'b10100,
	STATE_21 = 5'b10101,
	STATE_22 = 5'b10110,
	STATE_23 = 5'b10111,
	STATE_24 = 5'b11000,
	STATE_25 = 5'b11001,
	STATE_26 = 5'b11010,
	STATE_27 = 5'b11011,
	STATE_28 = 5'b11100,
	STATE_29 = 5'b11101,
	STATE_30 = 5'b11110,
	STATE_31 = 5'b11111;

reg[4:0] CurrentState;
reg[4:0] NextState;

initial enablee = 0;
initial enabled = 0;
initial enablel = 0;
	 
reg resetcounterl;
reg resetcounterdireccion;
reg resetcountere;
reg raa, rab, rac, rad, rae, raf, rag, rah;
wire listodireccion;
wire listolectura;
wire listoescritura;
wire [5:0] counterdireccion;
wire [4:0] counterl;
wire [4:0] countere;

	nuevodireccion dir
		(.clk(clk), .reset(reset), .resetcounterdireccion(resetcounterdireccion), .raa(raa), .rab(rab),
		 .rac(rac), .rad(rad), .rae(rae), .raf(raf), .rag(rag), .rah(rah), .fkaa(fkaa), .fkab(fkab), .fkac(fkac),
		 .fkad(fkad), .fkae(fkae), .fkaf(fkaf), .fkag(fkag), .fkah(fkah), .counterdireccion(counterdireccion),
		 .listodireccion(listodireccion), .acs(acs), .ard(ard), .awr(awr), .aad(aad));
	
	nuevoescritura esc
		(.clk(clk), .reset(reset), .resetcountere(resetcountere), .rda(rda), .rdb(rdb), .rdc(rdc), .rdd(rdd),
		 .rde(rde), .rdf(rdf), .rdg(rdg), .rdh(rdh), .countere(countere), .ecs(ecs), .erd(erd), .ewr(ewr), 
		 .ead(ead), .listoescritura(listoescritura), .fkda(fkda), .fkdb(fkdb), .fkdc(fkdc), .fkdd(fkdd), 
		 .fkde(fkde), .fkdf(fkdf) ,.fkdg(fkdg), .fkdh(fkdh));
	
	nuevolectura lec
		(.clk(clk), .reset(reset), .resetcounterl(resetcounterl), .lrda(lrda), .lrdb(lrdb), .lrdc(lrdc),
		 .lrdd(lrdd), .lrde(lrde), .lrdf(lrdf), .lrdg(lrdg), .lrdh(lrdh), .counterl(counterl), .lcs(lcs),
		 .lrd(lrd), .lwr(lwr), .lad(lad), .listolectura(listolectura), .lfkda(lfkda), .lfkdb(lfkdb), 
		 .lfkdc(lfkdc), .lfkdd(lfkdd), .lfkde(lfkde), .lfkdf(lfkdf), .lfkdg(lfkdg), .lfkdh(lfkdh));
	
always @(posedge clk) begin
	if (reset) CurrentState <= STATE_Initial;
	else CurrentState <= NextState;
end

always @(*) begin
	NextState = CurrentState;
	case (CurrentState)
		STATE_Initial: begin
			if ((enini)&(mandaunoa)) NextState = STATE_1;
			if ((enini)&(!mandaunoa)) NextState = STATE_3;
			if ((enwrite)&(ensec)) NextState = STATE_5;
			if ((enread)&(ensec)) NextState = STATE_7;
			if ((enwrite)&(enmin)) NextState = STATE_9;
			if ((enread)&(enmin)) NextState = STATE_11;
			if ((enwrite)&(enhour)) NextState = STATE_13;
			if ((enread)&(enhour)) NextState = STATE_15;
			if ((enwrite)&(enday)) NextState = STATE_17;
			if ((enread)&(enday)) NextState = STATE_19;
			if ((enwrite)&(enmonth)) NextState = STATE_21;
			if ((enread)&(enmonth)) NextState = STATE_23;
			if ((enwrite)&(enyear)) NextState = STATE_25;
			if ((enread)&(enyear)) NextState = STATE_27;
			if (configformato) NextState = STATE_29;
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablel <= 0;
			enablee <= 0;
			enabled <= 0;
			
			resetcountere <= 0;
			resetcounterdireccion <= 0;
			resetcounterl <= 0;
			
		end
		STATE_1: begin //inicializacion, escribe un 1, en la direccion 2, bit 4. Manda Direccion.
			if (listodireccion) NextState = STATE_2;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 1;
			rah <= 0;
			
			enabled <= 1;
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;
		end
		STATE_2: begin //inicializacion, escribe un 1, en la direccion 2, bit 4. Manda Dato.
			if (listoescritura) NextState = STATE_Initial;
			resetcountere <= 1;
			
			resetcounterdireccion <= 0;
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enabled <= 0;
			
			enablel <= 0;
			
			resetcounterl <= 0;
			
			enablee <= 1;
		end
		STATE_3: begin //inicializacion, escribe un 0, en la direccion 2, bit 4. Manda Direccion.
			if (listodireccion) NextState = STATE_4;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 1;
			rah <= 0;
			
			enabled <= 1;
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;
			
		end
		STATE_4: begin //inicializacion, escribe un 0, en la direccion 2, bit 4. Manda Dato.
			if (listoescritura) NextState = STATE_Initial;
			resetcountere <= 1;
			
			enablee <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablel <= 0;
			enabled <= 0;
			
			resetcounterdireccion <= 0;
			resetcounterl <= 0;
		end
		STATE_5: begin //escribe segundos. Manda Direccion.
			if (listodireccion) NextState = STATE_6;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 1;
			
			enabled <= 1;
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;
		end
		STATE_6: begin //escribe segundos. Manda Dato.
			if (listoescritura) NextState = STATE_Initial;
			resetcountere <= 1;
			
			enablee <= 1;	
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablel <= 0;
			enabled <= 0;
			
			resetcounterdireccion <= 0;
			resetcounterl <= 0;
		end
		STATE_7: begin //lee segundos. Manda Direccion.
			if (listodireccion) NextState = STATE_8;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 1;
			
			enabled <= 1;
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;
		end
		STATE_8: begin //lee segundos. Recibe Dato.
			if (listolectura) NextState = STATE_Initial;
			resetcounterl <= 1;
			
			enablel <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablee <= 0;
			enabled <= 0;
			
			resetcountere <= 0;
			resetcounterdireccion <= 0;
		end
		STATE_9: begin //escribe minutos. Manda Direccion.
			if (listodireccion) NextState = STATE_10;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 1;
			rah <= 0;
			
			enabled <= 1;
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;
		end
		STATE_10: begin //escribe minutos. Manda Dato.
			if (listoescritura) NextState = STATE_Initial;
			resetcountere <= 1;
			
			enablee <= 1;	
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablel <= 0;
			enabled <= 0;
			
			resetcounterdireccion <= 0;
			resetcounterl <= 0;
		end
		STATE_11: begin //lee minutos. Manda Direccion.
			if (listodireccion) NextState = STATE_12;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 1;
			rah <= 0;
			
			enabled <= 1;
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;
		end
		STATE_12: begin //lee minutos. Recibe Dato.
			if (listolectura) NextState = STATE_Initial;
			resetcounterl <= 1;
			
			enablel <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablee <= 0;
			enabled <= 0;
			
			resetcountere <= 0;
			resetcounterdireccion <= 0;
		end
		STATE_13: begin //escribe hora. Manda Direccion.
			if (listodireccion) NextState = STATE_14;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 1;
			rah <= 1;
			
			enabled <= 1;
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;
		end
		STATE_14: begin //escribe hora. Manda Dato.
			if (listoescritura) NextState = STATE_Initial;
			resetcountere <= 1;
			
			enablee <= 1;	

			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablel <= 0;
			enabled <= 0;
			
			resetcounterdireccion <= 0;
			resetcounterl <= 0;			
		end
		STATE_15: begin //lee hora. Manda Direccion.
			if (listodireccion) NextState = STATE_16;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 1;
			rah <= 1;
			
			enabled <= 1;
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;
		end
		STATE_16: begin //lee hora. Recibe Dato.
			if (listolectura) NextState = STATE_Initial;
			resetcounterl <= 1;
			
			enablel <= 1;

			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablee <= 0;
			enabled <= 0;
			
			resetcountere <= 0;
			resetcounterdireccion <= 0;		
		end
		STATE_17: begin //escribe dia. Manda Direccion. 
			if (listodireccion) NextState = STATE_18;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 1;
			rag <= 0;
			rah <= 0;
			
			enabled <= 1;	
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;			
		end
		STATE_18: begin //escribe dia. Manda Dato.
			if (listoescritura) NextState = STATE_Initial;
			resetcountere <= 1;
			
			enablee <= 1;	

			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablel <= 0;
			enabled <= 0;
			
			resetcounterdireccion <= 0;
			resetcounterl <= 0;			
		end
		STATE_19: begin //lee dia. Manda Direccion.
			if (listodireccion) NextState = STATE_20;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 1;
			rag <= 0;
			rah <= 0;
			
			enabled <= 1;	
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;
		end
		STATE_20: begin //lee dia. Recibe Dato.
			if (listolectura) NextState = STATE_Initial;
			resetcounterl <= 1;
			
			enablel <= 1;		
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablee <= 0;
			enabled <= 0;
			
			resetcountere <= 0;
			resetcounterdireccion <= 0;
		end
		STATE_21: begin //escribe mes. Manda Direccion.
			if (listodireccion) NextState = STATE_22;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 1;
			rag <= 0;
			rah <= 1;
			
			enabled <= 1;		
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;			
		end
		STATE_22: begin //escribe mes. Manda Dato.
			if (listoescritura) NextState = STATE_Initial;
			resetcountere <= 1;
			
			enablee <= 1;		

			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablel <= 0;
			enabled <= 0;
			
			resetcounterdireccion <= 0;
			resetcounterl <= 0;			
		end
		STATE_23: begin //lee mes. Manda Direccion.
			if (listodireccion) NextState = STATE_20;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 1;
			rag <= 0;
			rah <= 1;
			
			enabled <= 1;	
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;			
		end
		STATE_24: begin //lee mes. Recibe Dato.
			if (listolectura) NextState = STATE_Initial;
			resetcounterl <= 1;
			
			enablel <= 1;

			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablee <= 0;
			enabled <= 0;
			
			resetcountere <= 0;
			resetcounterdireccion <= 0;		
		end
		STATE_25: begin //escribe año. Manda Direccion.
			if (listodireccion) NextState = STATE_22;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 1;
			rag <= 1;
			rah <= 0;
			
			enabled <= 1;		
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;			
		end
		STATE_26: begin //escribe año. Manda Dato.
			if (listoescritura) NextState = STATE_Initial;
			resetcountere <= 1;
			
			enablee <= 1;		

			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablel <= 0;
			enabled <= 0;
			
			resetcounterdireccion <= 0;
			resetcounterl <= 0;			
		end
		STATE_27: begin //lee año. Manda Direccion.
			if (listodireccion) NextState = STATE_20;
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 1;
			rad <= 0;
			rae <= 0;
			raf <= 1;
			rag <= 1;
			rah <= 0;
			
			enabled <= 1;	
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;			
		end
		STATE_28: begin //lee año. Manda Dato.
			if (listolectura) NextState = STATE_Initial;
			resetcounterl <= 1;
			
			enablel <= 1;		

			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablee <= 0;
			enabled <= 0;
			
			resetcountere <= 0;
			resetcounterdireccion <= 0;		
		end
		STATE_29: begin
			if ((listodireccion)&&(docehorasa)) NextState = STATE_30; //Formato de 12 horas.
			if ((listodireccion)&&(!docehorasa)) NextState = STATE_31; //Formato de 24 horas.
			resetcounterdireccion <= 1;
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enabled <= 1;	
			
			enablel <= 0;
			enablee <= 0;
			
			resetcountere <= 0;
			resetcounterl <= 0;
		end
		STATE_30: begin //12 horas. Aqui debo poner un 1 en el bit 4.
			if (listoescritura) NextState = STATE_Initial;
			resetcountere <= 1;
			
			enablee <= 1;	
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablel <= 0;
			enabled <= 0;
			
			resetcounterdireccion <= 0;
			resetcounterl <= 0;
		end
		STATE_31: begin //24 horas. Aqui debo poner un 0 en el bit 4.
			if (listoescritura) NextState = STATE_Initial;
			resetcountere <= 1;
			
			enablee <= 1;	
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
			
			enablel <= 0;
			enabled <= 0;
			
			resetcounterdireccion <= 0;
			resetcounterl <= 0;
		end
	endcase
end

always @(*) begin
	if (enablee) begin
			cs <= ecs;
			rd <= erd;
			wr <= ewr;
			ad <= ead;
	end
	if (enabled) begin
			cs <= acs;
			rd <= ard;
			wr <= awr;
			ad <= aad;
	end
	if (enablel) begin
			cs <= lcs;
			rd <= lrd;
			wr <= lwr;
			ad <= lad;
	end
end

endmodule
