`timescale 1ns / 10ps

module escribirleer(
		input wire clk, reset,
		input wire confighora, //Si este Switch esta activo puedo configurar la hora.
		input wire configfecha, //Si este Switch esta activo puedo configura la fecha.
		//input wire configtempo, //Si este Switch esta activo puedo configurar el temporizador.
		input wire docehoras, //Formato 12 horas si es 1. Formato 24 horas si es 0.
		input wire mandauno,
		input wire inicializar, escribir, leer,
		input wire [7:0] countsecs, countmins,
		input wire [7:0] countmonths,
		input wire [7:0] countdays, counthours,
		input wire [7:0] countyears,
		input wire [7:0] countleftright,
		input wire listolectura, listoescritura,
		output reg lees, leem, leeh, leed, leems, leea,
		output reg configformato,
		output reg docehorasa,
		output reg mandaunoa,
		output reg rda, rdb, rdc, rdd, rde, rdf, rdg, rdh,
		output reg enini, enwrite, enread,
		output reg ensec, enmin, enhour, enday, enmonth, enyear
		);

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
	STATE_20_PlaceHolder = 5'b10100,
	STATE_21_PlaceHolder = 5'b10101,
	STATE_22_PlaceHolder = 5'b10110,
	STATE_23_PlaceHolder = 5'b10111,
	STATE_24_PlaceHolder = 5'b11000,
	STATE_25_PlaceHolder = 5'b11001,
	STATE_26_PlaceHolder = 5'b11010,
	STATE_27_PlaceHolder = 5'b11011,
	STATE_28_PlaceHolder = 5'b11100,
	STATE_29_PlaceHolder = 5'b11101,
	STATE_30_PlaceHolder = 5'b11110,
	STATE_31_PlaceHolder = 5'b11111;

reg[4:0] CurrentState;
reg[4:0] NextState;

always @(posedge clk) begin
	if (reset) CurrentState <= STATE_Initial;
	else CurrentState <= NextState;
end

always @(*) begin
	NextState = CurrentState;
	case (CurrentState)
		STATE_Initial: begin
			if (inicializar) NextState = STATE_10;
			else if (escribir) NextState =  STATE_1;
			else if (docehoras) NextState = STATE_11;
			else if (!docehoras) NextState = STATE_12;
			else if ((leer)) NextState = STATE_13;			
			
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 0;
			enini <= 0;
			enread <= 0;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_1: begin
			if (confighora) NextState = STATE_2;
			if (configfecha) NextState = STATE_6;
			
			
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 0;
			enini <= 0;
			enread <= 0;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_2: begin
			if (countleftright == 1) NextState = STATE_3;
			if (countleftright == 2) NextState = STATE_4;
			if (countleftright == 3) NextState = STATE_5;
			
			
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 0;
			enini <= 0;
			enread <= 0;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
			
		end
		STATE_3: begin //editar horas
			if (listoescritura) NextState = STATE_19;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 1;
			enini <= 0;
			enread <= 0;
			enhour <= 1;
			ensec <= 0;
			enmin <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0; 
			rdd <= counthours[4];
			rde <= counthours[3];
			rdf <= counthours[2];
			rdg <= counthours[1];
			rdh <= counthours[0];
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_4: begin //editar minutos
			if (listoescritura) NextState = STATE_19;
		
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 1;
			enini <= 0;
			enread <= 0;
			enmin <= 1;
			ensec <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= countmins[5]; 
			rdd <= countmins[4];
			rde <= countmins[3];
			rdf <= countmins[2];
			rdg <= countmins[1];
			rdh <= countmins[0];
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_5: begin //editar segundos
			if (listoescritura) NextState = STATE_19;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 1;
			enini <= 0;
			enread <= 0;
			ensec <= 1;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= countsecs[5]; 
			rdd <= countsecs[4];
			rde <= countsecs[3];
			rdf <= countsecs[2];
			rdg <= countsecs[1];
			rdh <= countsecs[0];
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_6: begin
			if (countleftright == 1) NextState = STATE_7;
			if (countleftright == 2) NextState = STATE_8;
			if (countleftright == 3) NextState = STATE_9;		
			
			
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 0;
			enini <= 0;
			enread <= 0;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_7: begin //editar dia
			if (listoescritura) NextState = STATE_19;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 1;
			enini <= 0;
			enread <= 0;
			enday <= 1;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0; 
			rdd <= countdays[4];
			rde <= countdays[3];
			rdf <= countdays[2];
			rdg <= countdays[1];
			rdh <= countdays[0];	

			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;			
		end
		STATE_8: begin //editar mes
			if (listoescritura) NextState = STATE_19;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 1;
			enini <= 0;
			enread <= 0;
			enmonth <= 1;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0; 
			rdd <= 0;
			rde <= countmonths[3];
			rdf <= countmonths[2];
			rdg <= countmonths[1];
			rdh <= countmonths[0];	
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_9: begin //editar año
			if (listoescritura) NextState = STATE_19;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 1;
			enini <= 0;
			enread <= 0;
			enyear <= 1;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			
			rda <= 0;
			rdb <= countyears[6];
			rdc <= countyears[5]; 
			rdd <= countyears[4];
			rde <= countyears[3];
			rdf <= countyears[2];
			rdg <= countyears[1];
			rdh <= countyears[0];	

			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;			
		end
		STATE_10: begin // envio dato para inicializar.
			if (listoescritura) NextState = STATE_19;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 0;
			enread <= 0;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			enini <= 1;
			
			if (mandauno) begin
				mandaunoa <= 1;
				rda <= 0;
				rdb <= 0;
				rdc <= 0;
				rdd <= 1;
				rde <= 0;
				rdf <= 0;
				rdg <= 0;
				rdh <= 0;
			end
			else if (!mandauno) begin
				mandaunoa <= 0;
				rda <= 0;
				rdb <= 0;
				rdc <= 0;
				rdd <= 0;
				rde <= 0;
				rdf <= 0;
				rdg <= 0;
				rdh <= 0;
			end
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
			
		end
		STATE_11: begin
			if (listoescritura) NextState = STATE_19;
			
			configformato <= 1;
			docehorasa <= 1;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdd <= 1;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			enwrite <= 0;
			enini <= 0;
			enread <= 0;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		
		STATE_12: begin
			if (listoescritura) NextState = STATE_19;
			
			configformato <= 1;
			docehorasa <= 0;
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			enwrite <= 0;
			enini <= 0;
			enread <= 0;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_13: begin //leer segundos.
			if (listolectura) NextState = STATE_14;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enread <= 1;
			ensec <= 1;
			
			enwrite <= 0;
			enini <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			lees <= 1;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_14: begin //leer minutos.
		
			if (listolectura) NextState = STATE_15;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enread <= 1;
			enmin <= 1;
			
			enwrite <= 0;
			enini <= 0;
			ensec <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			lees <= 0;
			leem <= 1;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_15: begin //leer horas.
		
			if (listolectura) NextState = STATE_16;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enread <= 1;
			enhour <= 1;
			
			enwrite <= 0;
			enini <= 0;
			ensec <= 0;
			enmin <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			lees <= 0;
			leem <= 0;
			leeh <= 1;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_16: begin //leer dias.
		
			if (listolectura) NextState = STATE_17;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enread <= 1;
			enday <= 1;
			
			enwrite <= 0;
			enini <= 0;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 1;
			leems <= 0;
			leea <= 0;
		end 
		STATE_17: begin //leer meses.
			if (listolectura) NextState = STATE_18;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enread <= 1;
			enmonth <= 1;
			
			enwrite <= 0;
			enini <= 0;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 1;
			leea <= 0;
		end
		STATE_18: begin //leer años.
			if (listolectura) NextState = STATE_19;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enread <= 1;
			enyear <= 1;
			
			enwrite <= 0;
			enini <= 0;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 1;
		end
		STATE_19: begin
			NextState = STATE_Initial;
			
			configformato <= 0;
			docehorasa <= 0;
			
			enwrite <= 0;
			enini <= 0;
			enread <= 0;
			ensec <= 0;
			enmin <= 0;
			enhour <= 0;
			enday <= 0;
			enmonth <= 0;
			enyear <= 0;
			
			rda <= 0;
			rdb <= 0;
			rdc <= 0;
			rdc <= 0;
			rdd <= 0;
			rde <= 0;
			rdf <= 0;
			rdg <= 0;
			rdh <= 0;
			
			lees <= 0;
			leem <= 0;
			leeh <= 0;
			leed <= 0;
			leems <= 0;
			leea <= 0;
		end
		STATE_20_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_21_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_22_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_23_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_24_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_25_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_26_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_27_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_28_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_29_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_30_PlaceHolder: begin
			NextState = STATE_Initial;
		end
		STATE_31_PlaceHolder: begin
			NextState = STATE_Initial;
		end
	endcase
end


endmodule
