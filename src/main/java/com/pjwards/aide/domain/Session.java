package com.pjwards.aide.domain;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.*;
import java.util.Set;

@Entity
public class Session {

    private static final Logger LOGGER = LoggerFactory.getLogger(Session.class);
    public static final int MAX_LENGTH_TITLE = 200;
    public static final int MAX_LENGTH_SLIDE_URL = 255;
    public static final int MAX_LENGTH_VIDEO_URL = 255;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(nullable = false, length = MAX_LENGTH_TITLE)
    private String title;

    @Lob()
    @Column(nullable = false)
    private String description;

    @Column(length = MAX_LENGTH_SLIDE_URL)
    private String slideUrl;

    @Lob()
    @Column()
    private String slideEmbed;

    @Column(length = MAX_LENGTH_VIDEO_URL)
    private String videoUrl;

    @Lob()
    @Column()
    private String videoEmbed;

    @ManyToOne
    @JoinColumn(name = "program_id")
    @JsonManagedReference
    private Program program;

    @ManyToOne
    @JoinColumn(name = "room_id")
    @JsonManagedReference
    private Room room;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "SPEAKER_SESSION",
            joinColumns = @JoinColumn(name = "SESSION_ID_FRK"),
            inverseJoinColumns = @JoinColumn(name = "SPEAKER_ID_FRK")
    )
    @JsonManagedReference
    private Set<User> speakerSet;

    public Session() {
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public Session setTitle(String title) {
        this.title = title;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public Session setDescription(String description) {
        this.description = description;
        return this;
    }

    public String getSlideUrl() {
        if (slideUrl == null || slideUrl.equals("") || slideUrl.startsWith("http://") || slideUrl.startsWith("https://"))
            return slideUrl;
        return "http://" + slideUrl;
    }

    public Session setSlideUrl(String slideUrl) {
        this.slideUrl = slideUrl;
        return this;
    }

    public String getVideoUrl() {
        if (videoUrl == null || videoUrl.equals("") || videoUrl.startsWith("http://") || videoUrl.startsWith("https://"))
            return videoUrl;
        return "http://" + videoUrl;
    }

    public Session setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
        return this;
    }

    public Program getProgram() {
        return program;
    }

    public Session setProgram(Program program) {
        this.program = program;
        return this;
    }

    public Room getRoom() {
        return room;
    }

    public Session setRoom(Room room) {
        this.room = room;
        return this;
    }

    public Set<User> getSpeakerSet() {
        return speakerSet;
    }

    public Session setSpeakerSet(Set<User> speakerSet) {
        this.speakerSet = speakerSet;
        return this;
    }

    public String getSlideEmbed() {
        return slideEmbed;
    }

    public Session setSlideEmbed(String slideEmbed) {
        this.slideEmbed = slideEmbed;
        return this;
    }

    public String getVideoEmbed() {
        return videoEmbed;
    }

    public Session setVideoEmbed(String videoEmbed) {
        this.videoEmbed = videoEmbed;
        return this;
    }

    public boolean isSpeaker(User user) {
        for (User speaker : speakerSet) {
            if (speaker.getId().equals(user.getId())) {
                return true;
            }
        }
        return false;
    }

    public void update(Session updated) {
        this.title = updated.title;
        this.description = updated.description;
    }

    public static class Builder {
        private Session built;

        public Builder(String title, String description) {
            built = new Session();
            built.title = title;
            built.description = description;
        }

        public Session build() {
            return built;
        }

        public Builder program(Program program) {
            built.program = program;
            return this;
        }

        public Builder room(Room room) {
            built.room = room;
            return this;
        }

        public Builder speakerSet(Set<User> speakerSet) {
            built.speakerSet = speakerSet;
            return this;
        }

        public Builder slideUrl(String slideUrl) {
            built.slideUrl = slideUrl;
            return this;
        }

        public Builder videoUrl(String videoUrl) {
            built.videoUrl = videoUrl;
            return this;
        }

        public Builder slideEmbed(String slideEmbed) {
            built.slideEmbed = slideEmbed;
            return this;
        }

        public Builder videoEmbed(String videoEmbed) {
            built.videoEmbed = videoEmbed;
            return this;
        }
    }

    /*@Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }*/
}
