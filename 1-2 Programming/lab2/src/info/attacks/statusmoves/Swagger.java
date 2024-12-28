package info.attacks.statusmoves;
import ru.ifmo.se.pokemon.*;
public class Swagger extends StatusMove {
    public Swagger() {
        super(Type.NORMAL, 0, 90);
    }
    //Повышает атаку цели на две ступени и сбивает её с толку.
    @Override
    protected void applyOppEffects(Pokemon pok) {
        pok.setMod(Stat.ATTACK,2);
        Effect.confuse(pok);
    }
    @Override
    protected String describe(){
        return "использует атаку Swagger";
    }
}
