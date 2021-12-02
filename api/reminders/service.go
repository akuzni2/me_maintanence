package reminders

type Service interface {
	AddReminder(reminder Reminder) error
	GetReminders(username string) ([]Reminder, error)
	UpdateReminder(reminder Reminder) error
	DeleteReminder(reminderId int) error
}

type reminderService struct {
	repository Repository
}

func (s reminderService) AddReminder(reminder Reminder) error {
	err := s.repository.Add(reminder)
	return err
}

func (s reminderService) GetReminders(username string) ([]Reminder, error) {
	reminders, err := s.repository.GetAll(username)
	return reminders, err
}

func (s reminderService) UpdateReminder(reminder Reminder) error {
	err := s.repository.Update(reminder)
	return err
}

func (s reminderService) DeleteReminder(reminderId int) error {
	err := s.repository.Delete(reminderId)
	return err
}

func NewService(repository Repository) Service {
	return &reminderService{repository: repository}
}
