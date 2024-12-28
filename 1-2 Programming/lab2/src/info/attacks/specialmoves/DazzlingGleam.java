package info.attacks.specialmoves;
import ru.ifmo.se.pokemon.*;
public class DazzlingGleam extends SpecialMove {
    public DazzlingGleam() {
        super(Type.FAIRY, 80, 100);
    }
    //Наносит регулярный урон без дополнительного эффекта
    @Override
    protected boolean checkAccuracy(Pokemon att, Pokemon def) {
        return true;
    }
    protected String describe() {
        return "использует атаку Dazzling Gleam";
    }
}
