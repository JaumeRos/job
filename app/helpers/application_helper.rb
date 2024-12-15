module ApplicationHelper
  def meta_title(title)
    set_meta_tags title: title
  end

  def meta_description(desc)
    set_meta_tags description: desc
  end

  def set_job_meta_tags(job)
    set_meta_tags(
      title: job.title,
      description: "#{job.job_type} teaching position at #{job.company_name} in #{job.location}. #{truncate(job.description, length: 140)}",
      keywords: "#{job.title}, #{job.company_name}, #{job.location}, #{job.job_type}, teaching job",
      og: {
        title: "#{job.title} at #{job.company_name}",
        description: truncate(job.description, length: 140),
        type: 'article',
        url: job_url(job)
      }
    )
  end
end
