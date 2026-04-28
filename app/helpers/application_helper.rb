module ApplicationHelper
  # Extract username from email (e.g., "user@example.com" -> "user")
  def display_name(user)
    return "Guest" unless user&.email
    user.email.split('@').first.capitalize
  end

  # Get first initial for avatar
  def avatar_initial(user)
    return "?" unless user&.email
    user.email.first.upcase
  end

  # Generate avatar color based on email
  def avatar_color(user)
    return "#6b7280" unless user&.email

    colors = %w[
      3b82f6 8b5cf6 ec4899 f59e0b 10b981 06b6d4
      6366f1 a855f7 ef4444 f97316 84cc16 14b8a6
    ]

    index = user.email.sum(&:ord) % colors.length
    colors[index]
  end

  # Format message timestamp
  def message_timestamp(time)
    return "" unless time

    seconds = Time.current - time

    if seconds < 60
      "just now"
    elsif seconds < 3600
      "#{(seconds / 60).floor}m ago"
    elsif seconds < 86400
      "#{(seconds / 3600).floor}h ago"
    else
      time.strftime("%b %d, %I:%M %p")
    end
  end
end
