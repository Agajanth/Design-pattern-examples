from observer.observabledata import ObservableData


class Observable:
    def __init__(self, name):
        self._name = name
        self._observers = []
    
    def attach_observer(self, observer):
        self._observers.append(observer)
    
    def remove_observer(self, observer):
        self._observers.remove(observer)
        
    def notify_changes(self, value):
        for observer in self._observers:
            observer.notify_changes(ObservableData(self._name, value))
            