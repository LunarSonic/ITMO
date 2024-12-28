package info.attacks.physicalmoves;
import ru.ifmo.se.pokemon.*;
public class BodySlam extends PhysicalMove {
    public BodySlam() {
        super(Type.NORMAL, 85, 100);
    }
    //Имеет 30% вероятность парализовать цель.
    //Парализованные покемоны с вероятностью 25% не
    //смогут атаковать, а их скорость снижается на 50%
    @Override
    protected void applyOppEffects(Pokemon pok) {
        if(Math.random() <= 0.3) {
            Effect eff = new Effect();
            eff.condition(Status.PARALYZE);
            eff.attack(0.25); //вероятность срабатывания атаки покемона во время действия эффекта
            eff.stat(Stat.SPEED, (int)pok.getStat(Stat.SPEED)/2);
            pok.addEffect(eff);
        }
    }
    protected String describe() {
        return "использует атаку Body Slam";
    }
}

