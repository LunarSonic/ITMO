package classes.characters;
import classes.rooms.Room;
import enums.Direction;
import exceptions.InvalidCharacterSpeedException;
import records.Position;
import interfaces.Runnable;

public class Kid extends Character implements  Runnable {
    private FrekenBok frekenBok;

    public Kid(String name, int speed, Position position, Direction direction, Room currentRoom, FrekenBok frekenBok) throws InvalidCharacterSpeedException {
        super(name, speed, position, direction, currentRoom);
        if (frekenBok == null) {
            throw new IllegalArgumentException("FrekenBok не может быть null для Kid");
        }
        this.frekenBok = frekenBok;
    }

    public void takeAwayCarpetBeater() throws InvalidCharacterSpeedException {
        if (frekenBok.getCarpetBeater().isInUse() && (speed >= 15 || Math.random() < 0.4)) {
            frekenBok.loseCarpetBeater();
            System.out.println(getName() + " отобрал " + frekenBok.getCarpetBeater().getName() + " у " + frekenBok.getName());
            frekenBok.getCarpetBeater().take(this);
            increaseSpeed();
        } else {
            System.out.println(getName() + " не смог отобрать " + frekenBok.getCarpetBeater().getName() + " у " + frekenBok.getName());
        }
    }
    @Override
    public void run() {
        Direction directionToFrekenBok = getDirectionToSomeone(frekenBok);
        System.out.println(getName() + " начинает преследовать " + frekenBok.getName() + " в направлении " + directionToFrekenBok);
        move(directionToFrekenBok);
        increaseSpeed();
        //достаточно ли близко Kid к FrekenBok
        if (isCloseToSomeone(frekenBok)) {
            try {
                takeAwayCarpetBeater();
            } catch (InvalidCharacterSpeedException e) {
                System.out.println("Ошибка при попытке отобрать " + frekenBok.getCarpetBeater().getName() +" : " + e.getMessage());
            }
        }
    }
}