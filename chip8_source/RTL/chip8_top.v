`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: SELF
// Engineer: Daniel S Ellerbrock
// 
// Create Date: 10/25/2025 10:46:17 AM
// Design Name: 
// Module Name: ch8_top
// Description: Basic Chip-8 RAM walker for LED test
//////////////////////////////////////////////////////////////////////////////////

module ch8_top(
    input  wire       clk,        // 125 MHz input clock
    output reg  [7:0] data_out    // LED output
);
    localparam INVALID = 2'b00;
    localparam   FETCH = 2'b01;
    localparam  DECODE = 2'b10;
    localparam EXECUTE = 2'b11;
    // -------------------------
    // State Machine Vals
    // -------------------------
    reg [1:0] fdx_state;
    reg reset = 1;
    // -------------------------
    // RAM initialization
    // -------------------------
    reg [7:0] ram [0:4095];
    integer i;
    
    // -------------------------
    // CPU registers (placeholders)
    // -------------------------
    reg [15:0] I;
    reg [15:0] PC;
    reg [7:0]  delay;
    reg [7:0]  sound;
    reg [7:0]  gen_reg [15:0];
    reg [15:0] stack [31:0];
    // -------------------------
    // Intermediate Values
    // -------------------------   
    reg [7:0] data1;
    reg [7:0] data2;
    wire [15:0] next_pc;
    reg [3:0] instr;
    reg [3:0] X;
    reg [3:0] Y;
    reg [3:0] N;
    reg [7:0] NN;
    reg [11:0] NNN;


    
    assign next_pc = PC + 2;

    // -------------------------
    // Clock divider → clock enable pulse
    // -------------------------
    /* reg [27:0] clock_div = 0;
       wire tick = (clock_div == 28'd24_999_999);  // 125 MHz / 25M = 5 Hz */
    
    // -------------------------
    // RAM walker logic (runs every tick)
    // -------------------------
    /* reg [11:0] j = 0;          // 12-bit index into 4K RAM
       reg [7:0]  ram_data_out; */

    
    initial begin
        for (i = 0; i < 4096; i = i + 1)
            ram[i] = 8'hFF;

        $readmemh("snake.mem", ram);

        // optional display for simulation
        // for (i = 0; i < 16; i = i + 1)
        //    $display("RAM[%0d] = %h", i, ram[i]);
    end

    /* always @(posedge clk) begin
        if (tick)
            clock_div <= 0;
        else
            clock_div <= clock_div + 1;
    end */

    /* always @(posedge clk) begin
        if (tick) begin
            if (j == 12'd4095)
                j <= 0;
            else
                j <= j + 1;
            ram_data_out <= ram[j];
            data_out <= ram_data_out;
        end
    end */
    
    always @(posedge clk) begin
        if (reset == 1) begin
                I = 0;
               PC = 0;
            delay = 0;
            sound = 0; 
            reset = 0;
            fdx_state = 2'b01;
        end
        else begin
            case (fdx_state)
                FETCH: begin
                    fdx_state <= DECODE;
                    PC <= next_pc;
                    data1 <= ram[PC];
                    data2 <= ram[PC+1];
                end
            
                DECODE: begin
                    instr <= data1 [7:4];
                    X     <= data1 [3:0];
                    Y     <= data2 [7:4];
                    N     <= data2 [3:0];
                    NN    <= data2;
                    NNN  <= {data1[3:0],data2};
                    fdx_state <= EXECUTE;
                end
            
                EXECUTE: begin
                    case(instr)
                    
                    endcase
                    fdx_state <= FETCH;
                end
                default: fdx_state = INVALID;
            endcase
        end
    end

endmodule
