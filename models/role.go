package models

import "time"

type Role struct {
	Name        string              `json:"name"`
	Description string              `json:"description"`
	Parent      *Role               `json:"parent"`
	Children    []*Role             `json:"children"`
	AccessList  map[string][]string `json:"access_list"`
	CreatedAt   time.Time           `json:"created_at"`
	UpdateAt    time.Time           `json:"update_at"`
}
