package classes.characters;
import classes.rooms.Room;
import enums.Direction;
import exceptions.InvalidCharacterSpeedException;
import records.Position;
import java.util.Objects;

public abstract class Character {
    protected String name;
    protected int speed;
    protected Position position;
    protected Direction direction;
    protected Room currentRoom;

    public Character(String name, int speed, Position position, Direction direction, Room currentRoom)  {
        this.name = name;
        try {
            if (speed <= 0 || speed > 100) {
                throw new InvalidCharacterSpeedException("Скорость должна быть от 1 до 100");
            }
            this.speed = speed;
        } catch (InvalidCharacterSpeedException e) {
            //пусть это будет дефолтное значение
            this.speed = 10;
        }
        this.position = position;
        this.direction = direction;
        this.currentRoom = currentRoom;
    }

    public Position move(Direction direction) {
        Position newPosition = position.move(direction); //создаем новую позицию
        setPosition(newPosition); //проверка на то, сохраняется ли эта позиция в поле position
        System.out.println(getName() + " двигается в направлении " + getDirection() + ". " + getPosition());
        return position;
    }

    public Direction getDirectionToSomeone(Character target) {
        Position currentPosition = getPosition();
        Position targetPosition = target.getPosition();
        //cравниваем только по оси X
        if (currentPosition.x() < targetPosition.x()) {
            return Direction.RIGHT;
        } else if (currentPosition.x() > targetPosition.x()) {
            return Direction.LEFT;
        } else {
            return Math.random() < 0.5 ? Direction.LEFT : Direction.RIGHT;
        }
    }
    public boolean isCloseToSomeone(Character otherCharacter) {
        Position currentPosition = getPosition();
        Position otherPosition = otherCharacter.getPosition();
        return Math.abs(currentPosition.x() - otherPosition.x()) < 5
                && Math.abs(currentPosition.y() - otherPosition.y()) < 5;
    }

    public void moveToRoom(Room room) {
        if(this.currentRoom != null) {
            this.currentRoom.leaveRoom(this); //покидаем текущую комнату
        }
        this.currentRoom = room;
        room.enterRoom(this); //заходим в новую комнату
    }

    public void increaseSpeed() {
        try {
            setSpeed(speed + 5);
            System.out.println(getName() + " увеличил скорость до " + getSpeed());
        } catch (InvalidCharacterSpeedException e) {
            System.out.println(e.getMessage());
        }
    }

    public String getName() {
        return name;
    }
    public int getSpeed() {
        return speed;
    }
    public Position getPosition() {
        return position;
    }
    public Direction getDirection() {
        return direction;
    }

    public void setPosition(Position newPosition) {
        if (newPosition.x() < 0 || newPosition.y() < 0) {
            throw new IllegalArgumentException("Координаты персонажей не могут быть отрицательными");
        }
        this.position = newPosition;
    }

    public void setSpeed(int speed) throws InvalidCharacterSpeedException {
        if (speed <= 0 || speed > 100) {
            throw new InvalidCharacterSpeedException("Скорость должна быть от 1 до 100. Получено: " + speed);
        }
        this.speed = speed;
    }

    @Override
    public String toString() {
        return "персонаж: " + getName();
    }
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Character character = (Character) obj;
        return speed == character.speed &&
                Objects.equals(name, character.name) &&
                Objects.equals(position, character.position) &&
                Objects.equals(direction, character.direction) &&
                Objects.equals(currentRoom, character.currentRoom);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, speed, position, direction, currentRoom);
    }
}
