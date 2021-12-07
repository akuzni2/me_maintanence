package reminders

type Reminder struct {
	Id                 int    `json:"id"`
	PreventativeCareId int    `json:"preventativeCareId"`
	Username           string `json:"username"`
	ReminderDateEpoch  int    `json:"reminderDateEpoch"`
}

type GetRemindersResponse struct {
	Reminders []Reminder `json:"reminders,omitempty"`
}
