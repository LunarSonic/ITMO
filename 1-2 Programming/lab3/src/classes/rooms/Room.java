package classes.rooms;
import enums.ActionType;
import java.util.ArrayList;
import classes.characters.Character;

public abstract class Room {
    protected String name;
    protected ArrayList<Character> characters;
    public Room(String name) {
        this.name = name;
        this.characters = new ArrayList<>();
    }

    protected abstract String describeAction(Character character, ActionType actionType);

    public void enterRoom(Character character)  {
        if(!characters.contains(character)) {
            characters.add(character);
            String action = describeAction(character, ActionType.ENTER);
            System.out.println(action);
        }

    }
    public void leaveRoom(Character character) {
        if(characters.contains(character)) {
            characters.remove(character);
            String action = describeAction(character, ActionType.LEAVE);
            System.out.println(action);
        }
    }

    public void showCharactersInRoom() {
        if(!characters.isEmpty()) {
            System.out.println("В " + getName() + " находятся");
            for(Character character: characters) {
                System.out.println(character);
            }
        } else {
            System.out.println("В " + getName() + " никого нет");
        }
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return "Комната: " + getName() + ", количество персонажей: " + characters.size();
    }
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Room room = (Room) obj;
        return name.equals(room.name);
    }
    @Override
    public int hashCode() {
        return name.hashCode();
    }
}
