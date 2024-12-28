package classes.characters;
import classes.rooms.Room;
import enums.Direction;
import exceptions.InvalidCharacterSpeedException;
import interfaces.Soundable;
import interfaces.Runnable;
import records.Position;
import java.util.Random;

public class Karlson extends Character implements Runnable, Soundable {
    private int altitude;
    private boolean attackedByFrekenBok = false;
    private Random random;

    public Karlson(String name, int speed, Position position, Direction direction, Room currentRoom) throws InvalidCharacterSpeedException {
        super(name, speed, position, direction, currentRoom);
        this.altitude = 0;
        random = new Random();
    }

    @Override
    public void makeSound() {
        System.out.println(getName() + " визжит от радости!");
    }

    @Override
    public void run() {
        Direction newDirection = Math.random() < 0.5 ? Direction.LEFT : Direction.RIGHT;
        System.out.println(getName() + " начинает бежать в направлении " + direction);
        move(newDirection);
        increaseSpeed();
    }

    public void accelerate() throws InvalidCharacterSpeedException {
        int newSpeed = getSpeed() + 10;
        setSpeed(newSpeed);
        System.out.println(getName() + " ускоряется. Новая скорость: " + newSpeed);
    }

    public void increaseAltitude(int change) {
        altitude += change;
        if (altitude < 0) {
            altitude = 0;
        }
        System.out.println(getName() + " увеличивает высоту полёта на " + change + ". Текущая высота: " + altitude);
    }

    public void decreaseAltitude(int change) {
        altitude -= change;
        if (altitude < 0) {
            altitude = 0;
        }
        System.out.println(getName() + " спускается на " + change + ". Текущая высота: " + altitude);
        if (altitude == 0) {
            System.out.println(getName() + " теперь на земле");
            Position currentPosition = getPosition();
            int currentX = currentPosition.getX();
            Position newPosition = new Position(currentX, 0);
            setPosition(newPosition);
        }
    }

    public void avoidHitting(FrekenBok frekenBok) {
        if (frekenBok.getCarpetBeater().isInUse() && frekenBok.getCarpetBeater().getHolder() == frekenBok) {
            System.out.println(getName() + " в зоне выбивалки");
            boolean attackeByFrekenBok = Math.random() < 0.7;
            if (attackeByFrekenBok) {
                System.out.println(getName() + " не успевает уклониться от " + frekenBok.getCarpetBeater().getName());
                attackedByFrekenBok = true;
            } else {
                System.out.println(getName() + " успешно уклонился от " + frekenBok.getCarpetBeater().getName());
                attackedByFrekenBok = false;
            }
        }
    }

    public void fly() throws InvalidCharacterSpeedException {
        Direction newDirection = Math.random() < 0.5 ? Direction.LEFT : Direction.RIGHT;
        System.out.println(getName() + " взлетает в направлении " + newDirection);
        move(newDirection);
        int increase = random.nextInt(20);
        increaseAltitude(increase);
        accelerate();
    }

    //метод для полёта между комнатами
    public void flyTo(Room newRoom) {
        System.out.println(getName() + " улетает из " + currentRoom.getName() + " в " + newRoom.getName());
        currentRoom.leaveRoom(this);
        currentRoom = newRoom;
        //пусть комната имеет размер 100 на 100
        //устанавливаем позицию в пределах комнаты
        int newX = random.nextInt(100);
        int newY = random.nextInt(100);
        setPosition(new Position(newX, newY));

        currentRoom.enterRoom(this);
        System.out.println(getName() + " теперь находится в " + currentRoom.getName() + ". " + getPosition());
    }

    public boolean isAttackedByFrekenBok() {
        return attackedByFrekenBok;
    }
    public int getAltitude() {
        return altitude;
    }
}
