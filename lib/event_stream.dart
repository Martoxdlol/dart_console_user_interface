class ConsoleEvent {
  ConsoleEvent();
}

class Subscription {
  final void Function(ConsoleEvent event) onData;
  final ConsoleEventsStream stream;
  Subscription(this.onData, this.stream);

  void cancel() {
    stream.unsubscribe(this);
  }
}

class ConsoleEventsStream {
  final Set<Subscription> subscriptions = <Subscription>{};

  Subscription listen(void Function(ConsoleEvent) onData) {
    final sub = Subscription(onData, this);
    subscriptions.add(sub);
    return sub;
  }

  void unsubscribe(Subscription subscription) {
    subscriptions.remove(subscription);
  }

  void emitEvent(ConsoleEvent event) {
    for (final element in subscriptions) {
      element.onData(event);
    }
  }
}
