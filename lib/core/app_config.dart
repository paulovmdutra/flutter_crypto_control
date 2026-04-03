class AppConfig {
  static const repositoryMode = String.fromEnvironment(
    'REPOSITORY_MODE',
    defaultValue: 'mock',
  );
}
