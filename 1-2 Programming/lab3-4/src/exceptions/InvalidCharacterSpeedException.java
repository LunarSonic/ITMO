package exceptions;
public class InvalidCharacterSpeedException extends Exception {
    public InvalidCharacterSpeedException(String message) {
        super(message);
    }
    @Override
    public String getMessage() {
        return "Такой скорости не может быть у персонажа" + super.getMessage();
    }
}