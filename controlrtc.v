`timescale 1ns / 10ps

module controlrtc(
	input wire clk, reset,
	input wire rda, rdb, rdc, rdd, rde, rdf, rdg, rdh,
	input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh,
	input wire enini, enwrite, enread,
	input wire ensec, enmin, enhour, enday, enmonth, enyear,
	input wire configformato, 
	input wire docehorasa,
	input wire mandaunoa,
	output wire listo,
	output wire listoe, listod,
	output reg enablee, enabled, enablel,
	output wire listolectura, listoescritura, listodireccion,
	output wire acs, awr, ard, aad, ecs, ewr, erd, ead, lcs, lwr, lrd, lad,
	output wire fkaa, fkab, fkac, fkad, fkae, fkaf, fkag, fkah,
	output wire lfkda, lfkdb, lfkdc, lfkdd, lfkde, lfkdf, lfkdg, lfkdh,
	output wire fkda, fkdb, fkdc, fkdd, fkde, fkdf, fkdg, fkdh
    );	

localparam STATE_Initial = 6'b000000,
	STATE_1 = 6'b000001,
	STATE_2 = 6'b000010,
	STATE_3 = 6'b000011,
	STATE_4 = 6'b000100,
	STATE_5 = 6'b000101,
	STATE_6 = 6'b000110,
	STATE_7 = 6'b000111,
	STATE_8 = 6'b001000,
	STATE_9 = 6'b001001,
	STATE_10 = 6'b001010,
	STATE_11 = 6'b001011,
	STATE_12 = 6'b001100,
	STATE_13 = 6'b001101,
	STATE_14 = 6'b001110,
	STATE_15 = 6'b001111,
	STATE_16 = 6'b010000,
	STATE_17 = 6'b010001,
	STATE_18 = 6'b010010,
	STATE_19 = 6'b010011,
	STATE_20 = 6'b010100,
	STATE_21 = 6'b010101,
	STATE_22 = 6'b010110,
	STATE_23 = 6'b010111,
	STATE_24 = 6'b011000,
	STATE_25 = 6'b011001,
	STATE_26 = 6'b011010,
	STATE_27 = 6'b011011,
	STATE_28 = 6'b011100,
	STATE_29 = 6'b011101,
	STATE_30 = 6'b011110,
	STATE_31 = 6'b011111,
	STATE_32 = 6'b100000,
	STATE_33_PlaceHolder = 6'b100001,
	STATE_34_PlaceHolder = 6'b100010,
	STATE_35_PlaceHolder = 6'b100011,
	STATE_36_PlaceHolder = 6'b100100,
	STATE_37_PlaceHolder = 6'b100101,
	STATE_38_PlaceHolder = 6'b100110,
	STATE_39_PlaceHolder = 6'b100111,
	STATE_40_PlaceHolder = 6'b101000,
	STATE_41_PlaceHolder = 6'b101001,
	STATE_42_PlaceHolder = 6'b101010,
	STATE_43_PlaceHolder = 6'b101011,
	STATE_44_PlaceHolder = 6'b101100,
	STATE_45_PlaceHolder = 6'b101101,
	STATE_46_PlaceHolder = 6'b101110,
	STATE_47_PlaceHolder = 6'b101111,
	STATE_48_PlaceHolder = 6'b110000,
	STATE_49_PlaceHolder = 6'b110001,
	STATE_50_PlaceHolder = 6'b110010,
	STATE_51_PlaceHolder = 6'b110011,
	STATE_52_PlaceHolder = 6'b110100,
	STATE_53_PlaceHolder = 6'b110101,
	STATE_54_PlaceHolder = 6'b110110,
	STATE_55_PlaceHolder = 6'b110111,
	STATE_56_PlaceHolder = 6'b111000,
	STATE_57_PlaceHolder = 6'b111001,
	STATE_58_PlaceHolder = 6'b111010,
	STATE_59_PlaceHolder = 6'b111011,
	STATE_60_PlaceHolder = 6'b111100,
	STATE_61_PlaceHolder = 6'b111101,
	STATE_62_PlaceHolder = 6'b111110,
	STATE_63_PlaceHolder = 6'b111111;

reg[5:0] CurrentState;
reg[5:0] NextState;

initial resetcounterl = 0;
initial resetcounterdireccion = 0;
initial resetcountere = 0;

reg resetcounterl;
reg resetcounterdireccion;
reg resetcountere;
reg raa, rab, rac, rad, rae, raf, rag, rah;
wire [5:0] counterdireccion;
wire [4:0] counterl;
wire [4:0] countere;

	direccion dir
		(.clk(clk), .reset(reset), .resetcounterdireccion(resetcounterdireccion), .raa(raa), .rab(rab),
		 .rac(rac), .rad(rad), .rae(rae), .raf(raf), .rag(rag), .rah(rah), .fkaa(fkaa), .fkab(fkab), .fkac(fkac),
		 .fkad(fkad), .fkae(fkae), .fkaf(fkaf), .fkag(fkag), .fkah(fkah), .counterdireccion(counterdireccion),
		 .listodireccion(listodireccion), .listod(listod), .acs(acs), .ard(ard), .awr(awr), .aad(aad));
	
	escritura esc
		(.clk(clk), .reset(reset), .resetcountere(resetcountere), .rda(rda), .rdb(rdb), .rdc(rdc), .rdd(rdd),
		 .rde(rde), .rdf(rdf), .rdg(rdg), .rdh(rdh), .countere(countere), .ecs(ecs), .erd(erd), .ewr(ewr), 
		 .ead(ead), .listoescritura(listoescritura), .listoe(listoe), .fkda(fkda), .fkdb(fkdb), .fkdc(fkdc), .fkdd(fkdd), 
		 .fkde(fkde), .fkdf(fkdf) ,.fkdg(fkdg), .fkdh(fkdh));
	
	lectura lec
		(.clk(clk), .reset(reset), .resetcounterl(resetcounterl), .lrda(lrda), .lrdb(lrdb), .lrdc(lrdc),
		 .lrdd(lrdd), .lrde(lrde), .lrdf(lrdf), .lrdg(lrdg), .lrdh(lrdh), .counterl(counterl), .lcs(lcs),
		 .lrd(lrd), .lwr(lwr), .lad(lad), .listolectura(listolectura), .listo(listo), .lfkda(lfkda), 
		 .lfkdb(lfkdb), .lfkdc(lfkdc), .lfkdd(lfkdd), .lfkde(lfkde), .lfkdf(lfkdf), .lfkdg(lfkdg), 
		 .lfkdh(lfkdh));
	
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
			if (listoescritura) NextState = STATE_32;
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
			if (listoescritura) NextState = STATE_32;
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
			if (listoescritura) NextState = STATE_32;
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
			if (listolectura) NextState = STATE_32;
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
			if (listoescritura) NextState = STATE_32;
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
			if (listolectura) NextState = STATE_32;
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
			if (listoescritura) NextState = STATE_32;
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
			if (listolectura) NextState = STATE_32;
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
			if (listoescritura) NextState = STATE_32;
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
			if (listolectura) NextState = STATE_32;
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
			if (listoescritura) NextState = STATE_32;
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
			if (listolectura) NextState = STATE_32;
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
			if (listoescritura) NextState = STATE_32;
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
			if (listolectura) NextState = STATE_32;
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
			if (listoescritura) NextState = STATE_32;
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
			if (listoescritura) NextState = STATE_32;
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
		STATE_32: begin
			NextState = STATE_Initial;
			resetcounterdireccion <= 0;
			resetcounterl <= 0;
			resetcountere <= 0;
			enabled <= 0;
			enablee <= 0;
			enablel <= 0;
			
			raa <= 0;
			rab <= 0;
			rac <= 0;
			rad <= 0;
			rae <= 0;
			raf <= 0;
			rag <= 0;
			rah <= 0;
		end
		STATE_33_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_34_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_35_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_36_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_37_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_38_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_39_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_40_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_41_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_42_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_43_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_44_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_45_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_46_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_47_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_48_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_49_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_50_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_51_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_52_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_53_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_54_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_55_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_56_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_57_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_58_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_59_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_60_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_61_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_62_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_63_PlaceHolder: begin
			NextState = STATE_Initial;
		end
	endcase
end

endmodule
