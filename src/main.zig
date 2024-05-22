const std = @import("std");
const rl = @import("raylib");
const Color = rl.Color;

const CellState = enum { empty, white, black };

const BOARD_SIZE: usize = 8;

const CELL_SIZE: i32 = 100;
const CELL_MARGIN: i32 = 5;
const CELL_PADDING: i32 = 5;

fn drawCell(x: usize, y: usize, state: CellState) void {
    const px_x: i32 = @intCast((x * CELL_SIZE) + CELL_MARGIN);
    const px_y: i32 = @intCast((y * CELL_SIZE) + CELL_MARGIN);
    const px_size: i32 = @intCast(CELL_SIZE - (CELL_MARGIN * 2));
    rl.drawRectangleLines(px_x, px_y, px_size, px_size, Color.black);

    if (state != CellState.empty) {
        const color = if (state == CellState.white) Color.white else Color.black;
        const px_center_x = px_x + (px_size / 2);
        const px_center_y = px_y + (px_size / 2);
        const px_radius = (px_size / 2) - (CELL_PADDING / 2);
        rl.drawCircle(px_center_x, px_center_y, px_radius, color);
    }
}

pub fn main() !void {
    var board: [BOARD_SIZE][BOARD_SIZE]CellState = undefined;
    for (0..BOARD_SIZE) |x| {
        for (0..BOARD_SIZE) |y| {
            board[x][y] = CellState.empty;
        }
    }

    const first_center = (BOARD_SIZE / 2) - 1;
    const second_center = first_center + 1;
    board[first_center][first_center] = CellState.white;
    board[first_center][second_center] = CellState.black;
    board[second_center][first_center] = CellState.black;
    board[second_center][second_center] = CellState.white;

    rl.initWindow(800, 800, "zothello");
    defer rl.closeWindow();

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        for (board, 0..) |row, x| {
            for (row, 0..) |state, y| {
                drawCell(x, y, state);
            }
        }

        rl.clearBackground(Color.dark_green);
    }
}
