package classes.items;
import classes.characters.Character;

public class CarpetBeater {
    private final String name;
    private Character holder;

    public CarpetBeater(String name) {
        this.name = name;
        this.holder = null;
    }

    public boolean isInUse() {
        return holder != null;
    }

    public Character getHolder() {
        return holder;
    }

    public void take(Character character) {
        if (holder != null) {
            System.out.println("Выбивалка уже у " + holder.getName());
        } else {
            holder = character;
            System.out.println(character.getName() + " взял выбивалку");
        }
    }

    public void release(Character character) {
        if(holder == null) {
            System.out.println(holder.getName() + " уже не держит " + getName());
        }
        holder = null;
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return getName() + "используется: " + (isInUse() ? "да" : "нет");
    }

}
