package classes.rooms;
import enums.ActionType;
import classes.characters.Character;

public class BigRoom extends Room{
    public BigRoom(String name) {
        super(name);
    }

    @Override
    protected String describeAction(Character character, ActionType actionType) {
        switch (actionType) {
            case ENTER:
                return character.getName() + " заходит в " + getName();
            case LEAVE:
                return character.getName() + " покидает " + getName();
            default:
                return "";
        }
    }

    @Override
    public String toString() {
        return "Большая комната";
    }
}
