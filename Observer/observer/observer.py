class Observer:
    def __init__(self, name):
        self._name = name
        
    def notify_changes(self, change):
        pass