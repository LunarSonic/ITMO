package records;
import enums.Direction;
public record Position(int x, int y) {
    public Position move(Direction direction) {
        switch (direction) {
            case UP:
                return new Position(x, y + 2);
            case DOWN:
                return new Position(x, y - 2);
            case LEFT:
                return new Position(x - 2, y);
            case RIGHT:
                return new Position(x + 2, y);
            default:
                return this;
        }
    }
    @Override
    public String toString() {
        return "Текущая позиция: (" + x + ", " + y + ")";
    }

    public int getX() {
        return x;
    }

    public int y() {
        return y;
    }
}