package info.attacks.statusmoves;
import ru.ifmo.se.pokemon.*;
public class Withdraw extends StatusMove {
    public Withdraw() {
        super(Type.WATER, 0, 0);
    }
    //Повышает свою Защиту на 1 ступень
    @Override
    protected void applySelfEffects(Pokemon pok) {
        pok.setMod(Stat.DEFENSE, +1);
    }
    @Override
    protected String describe() {
        return "использует атаку Withdraw";
    }
}
