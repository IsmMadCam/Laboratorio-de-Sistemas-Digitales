`timescale 1ns / 1ps

module buffer(
		input wire listo,
		input wire listoe, listod,
		input wire dartc, dbrtc, dcrtc, ddrtc, dertc, dfrtc, dgrtc, dhrtc,
		output wire datortc, dbtortc, dctortc, ddtortc, detortc, dftortc, dgtortc, dhtortc
    );

assign datortc = ((listo)|(listoe)|(listod))? dartc: 'bz;
assign dbtortc = ((listo)|(listoe)|(listod))? dbrtc: 'bz;
assign dctortc = ((listo)|(listoe)|(listod))? dcrtc: 'bz;
assign ddtortc = ((listo)|(listoe)|(listod))? ddrtc: 'bz;
assign detortc = ((listo)|(listoe)|(listod))? dertc: 'bz;
assign dftortc = ((listo)|(listoe)|(listod))? dfrtc: 'bz;
assign dgtortc = ((listo)|(listoe)|(listod))? dgrtc: 'bz;
assign dhtortc = ((listo)|(listoe)|(listod))? dhrtc: 'bz;
endmodule
