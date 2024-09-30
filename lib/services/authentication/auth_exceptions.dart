//Login Exception
class UserDisabledAuthException implements Exception {}

class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

class TooManyRequestsAuthException implements Exception {}

class InvalidCredentialAuthException implements Exception {}

//Register exceptions
class EmailAlreadyInUseAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class OperationNotAllowedAuthException implements Exception {}

//other
class InvalidEmailAuthException implements Exception {}

// Generic Exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class UserNotLoggedOut implements Exception {}
