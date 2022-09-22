from observer.observer import Observer


class Dashboard(Observer):
    def __init__(self, name):
        Observer.__init__(self, name)
        
    def notify_changes(self, change):
        print(f"{self._name} received changes: {change.name}: {change.data}")