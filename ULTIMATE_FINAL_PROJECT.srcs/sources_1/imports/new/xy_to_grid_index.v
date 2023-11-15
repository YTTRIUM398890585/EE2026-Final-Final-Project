`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 21:22:24
// Design Name: 
// Module Name: xy_to_grid_index
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module xy_to_grid #(
    /*Grid dimensions and parameters*/
    GRIDCELL_WIDTH = 33,
    GRIDCELL_HEIGHT = 16,
    GRID_COLUMNS = 3,
    GRID_ROWS = 4
    )(
    input CLOCK,
    input [7:0] x,
    input [6:0] y,
    output [3:0] grid_index,
    output [8:0] gridcell_index,
    output reg is_gridcell = 0
    );
    
    /*Determining grid cell row and column*/
    wire [1:0] grid_column;
    wire [2:0] grid_row;
    assign grid_column = x / (GRIDCELL_WIDTH);
    assign grid_row = y / (GRIDCELL_HEIGHT);
    
    /*Calculating grid index */
    assign grid_index = grid_column * GRID_ROWS + grid_row;
    
    /*Identifying grid cells excluding grid lines (to draw the lines)*/
    always @(posedge CLOCK) begin
        /*1st column*/
        if (x >= 1 && x <= 31 && y >= 1 && y <= 15) is_gridcell <= 1;
        else if (x >= 1 && x <= 31 && y >= 17 && y <= 31) is_gridcell <= 1;
        else if (x >= 1 && x <= 31 && y >= 33 && y <= 47) is_gridcell <= 1;
        else if (x >= 1 && x <= 31 && y >= 49 && y <= 63) is_gridcell <= 1;
        /* 2nd column */
        else if (x >= 33 && x <= 63 && y >= 1 && y <= 15) is_gridcell <= 1;
        else if (x >= 33 && x <= 63 && y >= 17 && y <= 31) is_gridcell <= 1;
        else if (x >= 33 && x <= 63 && y >= 33 && y <= 47) is_gridcell <= 1;
        else if (x >= 33 && x <= 63 && y >= 49 && y <= 63) is_gridcell <= 1;
        /*3rd column*/
        else if (x >= 65 && x <= 95 && y >= 1 && y <= 15) is_gridcell <= 1;
        else if (x >= 65 && x <= 95 && y >= 17 && y <= 31) is_gridcell <= 1;
        else if (x >= 65 && x <= 95 && y >= 33 && y <= 47) is_gridcell <= 1;
        else if (x >= 65 && x <= 95 && y >= 49 && y <= 63) is_gridcell <= 1;
        /*Otherwise, grid lines, borders etc.*/
        else is_gridcell <= 0;
    end
    
    /*Adjusting x and y for grid lines*/
    wire [7:0] adjusted_x;
    wire [6:0] adjusted_y;
    assign adjusted_x = x - 1;
    assign adjusted_y = y - 1;
    
    /*Calculating gridcell_index based on adjusted x and y to access ROM*/
    assign gridcell_index = (adjusted_y % GRIDCELL_HEIGHT) * 31 + (adjusted_x % GRIDCELL_WIDTH);
endmodule
