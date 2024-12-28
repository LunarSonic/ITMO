package info.attacks.statusmoves;
import ru.ifmo.se.pokemon.*;
public class DoubleTeam extends StatusMove{
    public DoubleTeam() {
        super(Type.NORMAL, 0, 0);
    }
    //Повышает своё уклонение на одну ступень
    @Override
    protected void applySelfEffects(Pokemon pok) {
        pok.setMod(Stat.EVASION, 1);
    }
    @Override
    protected String describe() {
        return "использует атаку Double Team";
    }
}
