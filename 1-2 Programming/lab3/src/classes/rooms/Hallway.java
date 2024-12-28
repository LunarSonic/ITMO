package classes.rooms;
import enums.ActionType;
import classes.characters.Character;

public class Hallway extends Room {
    public Hallway(String name) {
        super(name);
    }

    @Override
    protected String describeAction(Character character, ActionType actionType) {
        switch(actionType) {
            case ENTER:
                return character.getName() + " входит в " + getName();
            case LEAVE:
                return character.getName() + " быстро покидает " + getName();
            default:
                return "";
        }
    }

    @Override
    public String toString() {
        return "Коридор";
    }
}
