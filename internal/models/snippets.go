package models

import (
	"database/sql"
	"time"
)

type Snippet struct {
	ID      int       `json:"id"`
	Title   string    `json:"title"`
	Content string    `json:"content"`
	Created time.Time `json:"created"`
	Expires time.Time `json:"expires"`
}

type SnippetModel struct {
	DB *sql.DB
}

func (m *SnippetModel) Insert(title string, content string, expires int) (int, error) {
	query := `INSERT INTO snippets (title, content, created, expires)
            VALUES($1, $2, NOW(), NOW() + INTERVAL '$3 days')
            RETURNING id`

	stmt, err := m.DB.Prepare(query)
	if err != nil {
		return 0, err
	}

	var id int
	err = stmt.QueryRow(title, content, expires).Scan(&id)
	if err != nil {
		return 0, err
	}
	return id, nil
}

func (m *SnippetModel) Latest() ([]*Snippet, error) {
	return nil, nil
}
