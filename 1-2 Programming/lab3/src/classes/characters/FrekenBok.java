package classes.characters;
import classes.items.CarpetBeater;
import classes.rooms.Room;
import enums.Direction;
import exceptions.InvalidCharacterSpeedException;
import records.Position;
import interfaces.Runnable;

public class FrekenBok extends Character implements Runnable {
    private CarpetBeater carpetBeater;
    private Karlson karlson;

    public FrekenBok(String name, int speed, Position position, Direction direction, Room currentRoom, CarpetBeater carpetBeater, Karlson karlson) throws InvalidCharacterSpeedException {
        super(name, speed, position, direction, currentRoom);
        this.carpetBeater = carpetBeater;
        if (this.carpetBeater != null) {
            this.carpetBeater.take(this); //Фрекен Бок берёт выбивалку
        }
        if (karlson == null) {
            throw new IllegalArgumentException("Karlson не может быть null для FrekenBok");
        }
        this.karlson = karlson;
    }
    public void attackKarlson() {
        if(carpetBeater.isInUse() && carpetBeater.getHolder() == this) {
            System.out.println(getName() + " пытается ударить " + karlson.getName() + " , используя " + carpetBeater.getName());
            karlson.avoidHitting(this);
        } else {
            System.out.println(getName() + " не может ударить " + karlson.getName() + " , так как " + carpetBeater.getName() + " не у неё в руках");
        }
    }

    //бегает с выбивалкой для ковров
    @Override
    public void run() {
        Direction directionToKarlson = getDirectionToSomeone(karlson);
        printCarpetBeaterStatus();
        System.out.println(getName() + " начинает преследовать " + karlson.getName() + " в направлении " + directionToKarlson);
        move(directionToKarlson);
        increaseSpeed();
        if (isCloseToSomeone(karlson)) {
            System.out.println(getName() + " достаточно близко, чтобы атаковать " + karlson.getName());
            attackKarlson();
        } else {
            System.out.println(getName() + " находится далеко от " + karlson.getName() + ". Не может атаковать");
        }
    }

    private void printCarpetBeaterStatus() {
        if (carpetBeater.isInUse() && carpetBeater.getHolder() == this) {
            System.out.println(getName() + " держит в руках " + carpetBeater.getName() + " во время погони");
        } else {
            System.out.println(getName() + " не держит " + carpetBeater.getName() + ", её отобрали!");
        }
    }

    public void loseCarpetBeater() {
        if (carpetBeater != null && carpetBeater.isInUse() && carpetBeater.getHolder() == this) {
            System.out.println(getName() + " теряет " + carpetBeater.getName());
            carpetBeater.release(this);
        }
    }

    public CarpetBeater getCarpetBeater() {
        return carpetBeater;
    }
}
