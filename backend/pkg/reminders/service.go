package reminders

type Service interface {
	AddReminder(reminder Reminder) (Reminder, error)
	GetReminders(username string) ([]Reminder, error)
	GetRemindersYoungerThan(epoch int64) ([]ReminderInformation, error)
	UpdateReminder(reminder Reminder) error
	DeleteReminder(reminderId int) error
}

type reminderService struct {
	repository Repository
}

func (s reminderService) GetRemindersYoungerThan(epoch int64) ([]ReminderInformation, error) {
	reminders, err := s.repository.GetRemindersYoungerThan(epoch)
	return reminders, err
}

func (s reminderService) AddReminder(reminder Reminder) (Reminder, error) {
	rem, err := s.repository.Add(reminder)
	return rem, err
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
