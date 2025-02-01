package classes.characters;
import classes.rooms.Room;
import enums.Direction;
import interfaces.Soundable;
import records.Position;

public class Dog extends Character implements Soundable {
    private int barkVolume;

    public Dog(String name, int speed, Position position, Direction direction, Room currentRoom, int barkVolume) {
        super(name, speed, position, direction, currentRoom);
        this.barkVolume = barkVolume;
    }

    @Override
    public void makeSound() {
        System.out.println(getName() + " тявкает");
    }
    public void barkLouder() {
        this.barkVolume = 2*barkVolume;
        System.out.println(getName() + " громче гавкает");
    }

    public void jump() {
        Position currentPosition = getPosition(); //текущая позиция собаки
        Position newPosition = new Position(currentPosition.x(), currentPosition.y() + 2); //после прыжка новая координата Y
        setPosition(newPosition); //обновляем позицию
        System.out.println(getName() + " прыгает вверх на " + newPosition.y() + ". " + newPosition);
        System.out.println(getName() + " двигается за остальными ");
    }
}
